//
//  TaskListRepository.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 04/08/21.
//

import Combine
import Firebase
import FirebaseFirestore
import FirebaseStorage
import PhotosUI

final class TaskListRepository: ObservableObject {
    private let path = RepositoriesPath()
    private let store = Firestore.firestore()
    private let storage = Storage.storage()

    @Published var taskLists: [TaskList] = []

    static let shared = TaskListRepository()

    private init() {
        get()
    }

    func get() {
        store.collection(path.taskList)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting stories: \(error.localizedDescription)")
                    return
                }

                let taskLists = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: TaskList.self)
                } ?? []

                DispatchQueue.main.async {
                    self.taskLists = taskLists
                }
            }
    }

    func add(_ taskList: TaskList) {
        do {
            _ = try store.collection(path.taskList).addDocument(from: taskList)
        } catch {
            fatalError("Fail adding new task list")
        }
    }

    func delete(_ taskList: TaskList) {
        store.collection(path.taskList).document(taskList.id).delete()
    }

    func updateTask(taskID: String, name: String, desc: String, repeated: [Bool]) {
        store.collection(path.taskList).document(taskID).updateData([
            "name": name,
            "desc": desc,
            "repeated": repeated
        ])
    }

    func updatePhotoReference(taskID: String, photoRef: String, completion: ((Error?) -> Void)? = nil) {
        storage.reference().child(photoRef).downloadURL { [self] url, _ in
            if let url = url {
                store
                    .collection(path.taskList)
                    .document(taskID)
                    .setData(["photoReference": url.absoluteString], merge: true, completion: completion)
                store
                    .collection(path.task)
                    .document(taskID)
                    .setData(["photoReference": url.absoluteString], merge: true, completion: completion)
            }
        }
    }
    
    func repeatTask(day: String) {
        let dayDefault = UserDefaults.standard.integer(forKey: "currentDay")
        for tasks in taskLists {
            if let repeatedTask = tasks.repeated {
                for i in 0...repeatedTask.count {
                    if repeatedTask[i] {
                        if i == dayDefault {
                            add(tasks)
                        }
                    }
                }
            }
        }
    }
}
