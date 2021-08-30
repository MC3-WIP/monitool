//
//  TaskRepository.swift
//  monitool
//
//  Created by Devin Winardi on 27/07/21.
//

import Combine
import Firebase
import FirebaseFirestore
import FirebaseStorage
import PhotosUI

final class TaskRepository: ObservableObject {
    private let path = RepositoriesPath()
    private let store = Firestore.firestore()
    private let storage = Storage.storage()

    @Published var tasks: [Task] = []
    @Published var histories: [Task] = []
    @Published var completedTasks: [Task] = []

    static let shared = TaskRepository()

    private init() {
        get()
        getHistory()
    }

    func getHistory() {
        store.collection(path.task).whereField("isHistory", isEqualTo: true)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting stories: \(error.localizedDescription)")
                    return
                }

                let histories = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Task.self)
                } ?? []

                DispatchQueue.main.async {
                    self.histories = histories
                }
            }
    }

    func get() {
        store.collection(path.task).whereField("isHistory", isEqualTo: false)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting stories: \(error.localizedDescription)")
                    return
                }

                let tasks = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Task.self)
                } ?? []

                DispatchQueue.main.async {
                    self.tasks = tasks
                }
            }
    }

    func get(id: String, completion: ((Task?) -> Void)? = nil) {
        store.collection(path.task).document(id).getDocument { doc, err in
            if let err = err {
                print("Error getting document \(id)", err.localizedDescription)
                return
            }

            if let doc = doc {
                do {
                    let task = try doc.data(as: Task.self)
                    completion?(task)
                } catch {
                    print("Error parsing data, \(error.localizedDescription)")
                }
            }
        }
    }

    func getComplete() {
        store.collection(path.task).whereField("status", isEqualTo: "Completed")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting stories: \(error.localizedDescription)")
                    return
                }

                let completedTasks = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Task.self)
                } ?? []

                DispatchQueue.main.async {
                    self.completedTasks = completedTasks
                }
            }
    }

    func getChildTask(parentId: String, completion: (([Task]) -> Void)? = nil) {
        store.collection(path.task).whereField("parentId", isEqualTo: parentId).getDocuments { snapshot, err in
            if let err = err {
                print("Debug:", err.localizedDescription)
                fatalError()
            }
            guard let documents = snapshot?.documents else {
                print("Debug: No documents found.")
                fatalError()
            }
            self.tasks = documents.compactMap { snapshot in
                try? snapshot.data(as: Task.self)
            }
            completion?(self.tasks)
        }
    }

    func add(_ task: Task, _ taskList: TaskList, _ id: String, completion: ((Error?) -> Void)? = nil) {
        do {
            try store.collection(path.task).document(id).setData(from: task, completion: completion)
            try store.collection(path.taskList).document(id).setData(from: taskList, completion: completion)
        } catch {
            fatalError("Fail adding new task")
        }
    }

    func add(_ task: TaskList, _ id: String, completion: ((Error?) -> Void)? = nil) {
        store.collection(path.task).document(id).setData(
            ["name": task.name,
             "createdAt": Date(),
             "desc": task.desc ?? "",
             "isHistory": false,
             "photoReference": task.photoReference ?? "",
             "parentId": task.id as Any,
             "status": "Today List"], completion: completion)

    }

    func delete(_ task: Task) {
        store.collection(path.task).document(task.id).delete()
    }

    func updatePIC(taskID: String, employee: Employee) {
        let ref = store.collection(path.employee).document(employee.id)
        store.collection(path.task).document(taskID).setData(["pic": ref], merge: true)
    }

    func updateNotes(taskID: String, notes: String) {
        store.collection(path.task).document(taskID).setData(["notes": notes], merge: true)
    }

    func updateComment(taskID: String, comment: String) {
        store.collection(path.task).document(taskID).setData(["comment": comment], merge: true)
    }
    
    func updateStatus(taskID: String, status: String, completion: ((Error?) -> Void)? = nil) {
        if status == TaskStatus.completed.title {
            store
                .collection(path.task)
                .document(taskID)
                .updateData(["status": status, "isHistory": true], completion: completion)
        } else {
            store.collection(path.task).document(taskID).updateData(["status": status], completion: completion)
        }
    }
    
    func updateLogTask(taskID: String, titleLog: String, timeStamp: Date){
        store.collection(path.task).document(taskID).setData(
            [
                "titleLog" : FieldValue.arrayUnion([titleLog]),
                "timeStampLog" : FieldValue.arrayUnion([timeStamp]),
                
           ],
            merge: true
        )
    }

    func appendReviewer(approving: Bool = true, taskID: String, employee: Employee, completion: ((Error?) -> Void)? = nil) {
        let employeeRef: DocumentReference = store.collection(path.employee).document(employee.id)

        store
            .collection(path.task)
            .document(taskID)
            .setData(
                [approving ? "approvingReviewer" : "disapprovingReviewer": FieldValue.arrayUnion([employeeRef])],
                merge: true,
                completion: completion
            )
    }

    func updatePhotoReference(taskID: String, photoRef: String, completion: ((Error?) -> Void)? = nil) {
        storage.reference().child(photoRef).downloadURL { [self] url, _ in
            if let url = url {
                store
                    .collection(path.task)
                    .document(taskID)
                    .setData(["photoReference": url.absoluteString], merge: true, completion: completion)
                store
                    .collection(path.taskList)
                    .document(taskID)
                    .setData(["photoReference": url.absoluteString], merge: true, completion: completion)
            }
        }
    }

    func submitTask(task: Task, taskList: TaskList, photo: UIImage, id: String) {
        add(task, taskList, id) { _ in
            // Setelah task ada di firebase, baru upload photo
            StorageService
                .shared
                .upload(image: photo, path: "taskPhotoReference/\(id)/\(UUID().uuidString)") { metadata, _ in
                    // Setelah photo di upload, update field photo ref task tadi
                    if let metadata = metadata,
                       let path = metadata.path {
                        self.updatePhotoReference(taskID: id, photoRef: path)
                    }
                }
        }
    }

    func submitTask(task: Task, taskList: TaskList, id: String) {
        add(task, taskList, id)
    }

    func dropDisapprovingReviewer(taskID: String) {
        store
            .collection(path.task)
            .document(taskID)
            .setData(
                ["disapprovingReviewer": FieldValue.delete()],
                merge: true
            )
    }

    func repeatTask(day: Int, taskListRepo: TaskListRepository) {
        taskListRepo.get { taskList in
            for tasks in taskList {
                self.getChildTask(parentId: tasks.id) { task in
                    for childTask in task {
                        self.updateStatus(taskID: childTask.id, status: TaskStatus.completed.title)
                    }
                    if let repeatedTask = tasks.repeated {
                        for i in 0...repeatedTask.count - 1 where repeatedTask[i] && i == day {
                            self.add(tasks, "\(UUID().uuidString)")
                        }
                    }
                }
            }
        }
    }

}
