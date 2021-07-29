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

final class TaskRepository: ObservableObject {
	private let path = RepositoriesPath()
    private let store = Firestore.firestore()
    private let storage = Storage.storage()
    
    @Published var tasks: [Task] = []

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
//                    Map every document as a Story using data(as:decoder:). You can do this thanks to FirebaseFirestoreSwift,because Story conforms to Codable.
                    try? document.data(as: Task.self)
                } ?? []
                
                DispatchQueue.main.async {
                    self.tasks = tasks
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
//		guard let storyId = story.storyId else { return }
//		guard let docId = story.id else { return}
//
//		store.collection(path).document(docId).delete { error in
//			if let error = error {
//				print("Unable to remove card: \(error.localizedDescription)")
//			}  else {
//				print("Successfully deleted  story text")
//			}
//		}
//		storage.reference().child("stories/\(storyId)/1").delete { error in
//			if let error = error {
//				print("Unable to delete story image: \(error.localizedDescription)")
//			} else {
//				print("Successfully deleted  story image")
//			}
//		}
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
