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
    @Published var histories: [Task] = []
    @Published var completedTasks: [Task] = []

    init(){
		let dummyTask = Task(name: "beli kopi")
		add(dummyTask)
        get()
        getHistory()
    }
    
    func getHistory(){
        store.collection(path.task).whereField("isHistory", isEqualTo: true)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting stories: \(error.localizedDescription)")
                    return
                }
                
                let histories = querySnapshot?.documents.compactMap {document in
                    try? document.data(as: Task.self)
                } ?? []

                DispatchQueue.main.async {
                    self.histories = histories
                }
            }
    }
    
    func get(){
        store.collection(path.task).whereField("isHistory", isEqualTo: false)
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
    
    func add(_ task: Task) {
        do {
			_ = try store.collection("companies/mBz4gtAwSyQA8JDWhePN/tasks").addDocument(from: task)
        } catch{
            fatalError("Fail adding new task")
        }
    }

	func delete(_ task: Task) {
		store.collection("companies/mBz4gtAwSyQA8JDWhePN/tasks").document(task.id).delete()
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
