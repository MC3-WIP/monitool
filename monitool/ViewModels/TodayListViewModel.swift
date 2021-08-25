//
//  TodayListViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 07/08/21.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class TodayListViewModel: TaskDetailViewModel {
    
    @Published var notesText = ""
    @Published var picSelection = 0
    @Published var isEmployeePickerPresenting = false

    func submitTask(pic: Employee, notes: String? = nil) {
        taskRepository.updatePIC(taskID: task.id, employee: pic)

        if let notes = notes, notes != "" {
            taskRepository.updateNotes(taskID: task.id, notes: notes)
        }

        taskRepository.updateStatus(taskID: task.id, status: TaskStatus.waitingEmployeeReview.rawValue)
    }

    // Props
    @Published var proofOfWork: [String]?

    // Repository
    @Published private var store: Store = .shared

    // Modals state
    @Published var isImagePickerShowing = false

    // Fields
    @Published var taskTitle: String
    @Published var imageToBeAdded: UIImage?

    private var taskTitleHasChanges: Bool {
        task.name != taskTitle
    }

    var fieldsAreValid: Bool {
        !taskTitle.isEmpty
    }

    override init(task: Task) {
        taskTitle       = task.name
        proofOfWork     = task.proof
        super.init(task: task)
    }

    func showImagePicker() {
        isImagePickerShowing = true
    }

    func logError(error: Error?) {
        if let error = error {
            print("Debug:", error.localizedDescription)
            fatalError()
        }
    }

    private func handleTaskPostCompletion(_ error: Error?) {
        logError(error: error)

        // Dismiss Keyboard
        UIApplication.shared.endEditing()
    }

    private func handleImagePostCompletion(task: Task, _ metadata: StorageMetadata?, _ error: Error?) {
        logError(error: error)

        guard let metadata = metadata, let path = metadata.path else { return }

        store.getDownloadURL(path: path) { [self] url in
            store.update(
                task: task,
                field: .proof,
                with: FieldValue.arrayUnion([url])
            ) { _ in
                imageToBeAdded = nil
                proofOfWork?.append(url)
            }
        }
    }

    func post(task: Task) {
        guard let taskRef = store.post(task: task, completion: handleTaskPostCompletion) else {
            fatalError("Debug: Error posting new task.")
        }

        taskRef.getDocument { [self] snapshot, _ in
            do {
                guard let task = try snapshot?.data(as: Task.self) else { return }

                if let image = imageToBeAdded {
                    store.post(task: task, image: image) { metadata, error in
                        handleImagePostCompletion(task: task, metadata, error)
                    }
                }
            } catch {
                logError(error: error)
            }
        }
    }

    func update() {
        // Update changes, if any.
        if fieldsAreValid, taskTitleHasChanges {
            store.update(task: task, field: .name, with: taskTitle)
        }

        // Add proof of work, if any.
        if let image = imageToBeAdded {
            store.post(task: task, image: image) { [self] metadata, error in
                handleImagePostCompletion(task: task, metadata, error)
            }
        }
    }
}
