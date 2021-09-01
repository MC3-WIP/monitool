//
//  StorageService.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 04/08/21.
//

import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseStorage
import SwiftUI

class StorageService: ObservableObject {
    let storage = Storage.storage()
    var storageRef: StorageReference?
	@ObservedObject var companyViewModel: CompanyViewModel = .shared

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

    func updateImageURL(category: String) {
        // Create a reference
        if let id = Auth.auth().currentUser?.uid {
            storageRef = storage.reference().child("images/\(id)/\(category).jpg")
        }
        storageRef?.downloadURL { url, _ in
            self.companyViewModel.addImage(imageURL: url?.absoluteString ?? "profile")
        }
    }
}
