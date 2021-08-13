//
//  StorageService.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 04/08/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestoreSwift

class StorageService: ObservableObject {
    let storage = Storage.storage()
    var storageRef: StorageReference? = nil
    @ObservedObject var companyViewModel = CompanyViewModel()
    
    static let shared = StorageService()
    
    func upload(image: UIImage, path: String, completion: ((StorageMetadata?, Error?) -> Void)? = nil) {
        // Create a storage reference
        if let id = Auth.auth().currentUser?.uid {
            storageRef = storage.reference().child("images/\(id)/\(path).jpg")
        }
        
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let data = image.jpegData(compressionQuality: 0.2)
        
        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        // Upload the image
        if let data = data, let storage = storageRef {
            storage.putData(data, metadata: metadata, completion: completion)
        }
    }
    
    func listAllFiles() {
        // Create a reference
        let storageRef = storage.reference().child("images")
        
        // List all items in the images folder
        storageRef.listAll { (result, error) in
            if let error = error {
                print("Error while listing all files: ", error)
            }
            
            for item in result.items {
                print("Item in images folder: ", item)
            }
        }
    }
    
    func listItem(category: String) {
        // Create a reference
        if let id = Auth.auth().currentUser?.uid {
            storageRef = storage.reference().child("images/\(id)/\(category)")
        }
        
        // Create a completion handler - aka what the function should do after it listed all the items
        let handler: (StorageListResult, Error?) -> Void = { (result, error) in
            if let error = error {
                print("error", error)
            }
            
            let item = result.items
            print("item: ", item)
        }
        
        // List the items
        storageRef?.list(withMaxResults: 1, completion: handler)
    }
    
    func updateImageURL(category: String) {
        // Create a reference
        if let id = Auth.auth().currentUser?.uid {
            storageRef = storage.reference().child("images/\(id)/\(category).jpg")
        }
        storageRef?.downloadURL { url, _ in
            self.companyViewModel.addImage(imageURL: url?.absoluteString ?? "profile")
        }
    }
    
    // You can use the listItem() function above to get the StorageReference of the item you want to delete
    func deleteItem(item: StorageReference) {
        item.delete { error in
            if let error = error {
                print("Error deleting item", error)
            }
        }
    }
}
