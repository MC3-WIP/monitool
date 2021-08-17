//
//  TaskListRepository.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 04/08/21.
//

import Firebase
import Combine
import PhotosUI
import FirebaseStorage
import FirebaseFirestore

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

                let taskLists = querySnapshot?.documents.compactMap {document in
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

}
