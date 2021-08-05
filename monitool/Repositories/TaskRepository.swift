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

    init(){
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
    

    func updatePIC(_ idCompany: String, _ idTask: String, _ employee: Employee){
		store.collection(path.task).document(idCompany)
    }
    
    func updateNotes(id: String, notes: String) {
		store.collection(path.task).document(id).updateData([
            "notes" : notes
        ])
    }
    
    func updateStatus(id: String, status: String) {
		store.collection(path.task).document(id).updateData([
            "status" : status
        ])
    }
}
