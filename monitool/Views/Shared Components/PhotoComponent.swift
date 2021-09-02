//
//  PhotoComponent.swift
//  monitool
//
//  Created by Devin Winardi on 30/07/21.
//

import Foundation
import SDWebImageSwiftUI
import SwiftUI

struct PhotoComponent: View {
    @State var showImagePicker: Bool = false
    @State private var showActionSheet = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var image: UIImage?
    @State var imageURL: String

	@Binding var editMode: EditMode

	@ObservedObject var storageService: StorageService = .shared

    var body: some View {
        VStack {
            renderPhoto()
            if editMode.isEditing {
                UploadButton()
            }
        }
    }

    @ViewBuilder func renderPhoto() -> some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle())
        } else if !imageURL.isEmpty {
            WebImage(url: URL(string: imageURL))
                .resizable()
                .indicator { _, _ in
                    ProgressView()
                }
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle())
        } else {
            Image("profile")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle())
        }
    }

    @ViewBuilder func UploadButton() -> some View {
        Button("Upload photo") {
            self.showActionSheet.toggle()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: self.sourceType) { image in
                self.image = image
                if let image = self.image {
                    storageService.upload(image: image, path: "profile") { metadata, _ in
                        if let path = metadata?.path {
                            Store.shared.getDownloadURL(path: path) { url in
                                CompanyRepository.shared.updateProfileImage(url: url)
                            }
                        }
                    }
                }
            }
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Choose mode"),
                message: Text("Please choose your preferred mode to set your profile image"),
                buttons: [
                    .default(Text("Camera")) {
                        self.showImagePicker.toggle()
                        self.sourceType = .camera
                    },
                    .default(Text("Photo Library")) {
                        self.showImagePicker.toggle()
                        self.sourceType = .photoLibrary
                    },
                    .cancel()
                ]
            )
        }
    }
}

//
// struct PhotoComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoComponent(imageURL: "", editMode: .constant(EditMode.active))
//    }
// }
