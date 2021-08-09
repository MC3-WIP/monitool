//
//  TaskRepository.swift
//  monitool
//
//  Created by Devin Winardi on 27/07/21.
//

import Firebase
import Combine
import PhotosUI
import FirebaseStorage
import FirebaseFirestore

final class TaskRepository: ObservableObject {
	private let path = RepositoriesPath()
    private let store = Firestore.firestore()
    private let storage = Storage.storage()
    
    @Published var tasks: [Task] = []
    @Published var completedTasks: [Task] = []

	static let shared = TaskRepository()

    private init(){
        get()
    }
    
    func get(){
		store.collection(path.task)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting stories: \(error.localizedDescription)")
                    return
                }
                
                let tasks = querySnapshot?.documents.compactMap {document in
                    try? document.data(as: Task.self)
                } ?? []

                DispatchQueue.main.async {
                    self.tasks = tasks
                }
            }
    }
    
    func getComplete(){
        store.collection(path.task).whereField("status", isEqualTo: "Completed")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting stories: \(error.localizedDescription)")
                    return
                }
                
                let completedTasks = querySnapshot?.documents.compactMap {document in
                    try? document.data(as: Task.self)
                } ?? []
                
                DispatchQueue.main.async {
                    self.completedTasks = completedTasks
                }
            }
    }
    
    func add(_ task: Task) {
        do {
			_ = try store.collection(path.task).addDocument(from: task)
        } catch{
            fatalError("Fail adding new task")
        }
    }

	func delete(_ task: Task) {
		store.collection(path.task).document(task.id).delete()
	}
    

    func updatePIC(taskID: String, employee: Employee){
		let ref = store.collection(path.employee).document(employee.id)
		store.collection(path.task).document(taskID).setData(["pic" : ref], merge: true)
    }

    func updateNotes(taskID: String, notes: String) {
		store.collection(path.task).document(taskID).setData(["notes" : notes], merge: true)
    }
    
	func updateStatus(taskID: String, status: String, completion: ((Error?) -> Void)? = nil) {
		store
			.collection(path.task)
			.document(taskID)
			.updateData(
				["status" : status],
				completion: completion
			)
    }

	func appendReviewer(taskID: String, employee: Employee, completion: ((Error?) -> Void)? = nil) {
		let employeeRef: DocumentReference = store.collection(path.employee).document(employee.id)
		
		store
			.collection(path.task)
			.document(taskID)
			.setData(
				["reviewer" : FieldValue.arrayUnion([employeeRef])],
				merge: true,
				completion: completion
			)
	}
}
