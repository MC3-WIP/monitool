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

class TaskRepository: ObservableObject {
    private let path: String = "tasks"
    private let store = Firestore.firestore()
    private let storage = Storage.storage()
    
    @Published var tasks: [Task] = []
    
    func get(){
        store.collection(path)
            .addSnapshotListener{ querySnapshot, error in
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
    
    func updateNotes(id: String, notes: String) {
        store.collection(path).document(id).updateData([
            "notes" : notes
        ])
    }
    
    func updateStatus(id: String, status: String) {
        store.collection(path).document(id).updateData([
            "status" : status
        ])
    }
}
