//
//  CarouselRepository.swift
//  monitool
//
//  Created by Christianto Budisaputra on 25/08/21.
//

import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift
import FirebaseAuth

final class Store: ObservableObject {
    typealias StoreCompletionHandler = (Error?) -> Void
    typealias StorageCompletionHandler = (StorageMetadata?, Error?) -> Void

    enum Directory: String, CaseIterable {
        case tasks,
             images
    }

    private let store = Firestore.firestore()
    private let storage = Storage.storage()
    static let shared = Store()

    func post(task: Task, completion: StoreCompletionHandler? = nil) -> DocumentReference? {
        do {
            return try store
                .collection(Directory.tasks.rawValue)
                .addDocument(from: task, completion: completion)
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }

    func post(task: Task, image: UIImage, completion: StorageCompletionHandler? = nil) {
        if let data = image.jpegData(compressionQuality: 0.1),
           let metadata = StorageMetadata(dictionary: ["contentType": "image/jpg"]),
           let user = Auth.auth().currentUser,
           let taskID = task.id {
            storage
                .reference()
                .child("\(Directory.images.rawValue)/\(user.uid)/proofOfWork/\(taskID)/\(UUID().uuidString)")
                .putData(
                    data,
                    metadata: metadata,
                    completion: completion
                )
        }
    }

    func update(task: Task, field: Task.Field, with data: Any, completion: StoreCompletionHandler? = nil) {
        if let user = Auth.auth().currentUser {
        store
            .collection("companies/\(user.uid)/tasks")
            .document(task.id)
            .setData(
                [field.rawValue: data],
                merge: true,
                completion: completion
            )
        }
    }

    func getDownloadURL(path: String, completion: ((String) -> Void)? = nil) {
        storage.reference().child(path).downloadURL { url, err in
            if let err = err {
                print("Debug:", err.localizedDescription)
                fatalError()
            }

            if let url = url {
                completion?(url.absoluteString)
            }
        }
    }
}
