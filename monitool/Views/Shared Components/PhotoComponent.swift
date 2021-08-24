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

    @ObservedObject var profileViewModel: ProfileViewModel = .shared

    var imageURL: String
    @Binding var editMode: EditMode

    @ObservedObject var storageService = StorageService()

    var body: some View {
        VStack {
            if imageURL != "" {
                WebImage(url: URL(string: imageURL))
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                    .padding(.bottom, 10.0)
            } else {
                if image == nil {
                    Image("profile")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipShape(Circle())
                        .padding(.bottom, 10.0)
                } else {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipShape(Circle())
                            .padding(.bottom, 10.0)
                    }
                }
            }
            if editMode.isEditing {
                UploadButton()
            }
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
                    storageService.upload(image: image, path: "profile")
                }
            }
        }
        .actionSheet(isPresented: $showActionSheet) { () -> ActionSheet in
            ActionSheet(
                title: Text("Choose mode"),
                message: Text("Please choose your preferred mode to set your profile image"),
                buttons: [
                    ActionSheet.Button.default(Text("Camera")) {
                        self.showImagePicker.toggle()
                        self.sourceType = .camera
                    },
                    ActionSheet.Button.default(Text("Photo Library")) {
                        self.showImagePicker.toggle()
                        self.sourceType = .photoLibrary
                    },
                    ActionSheet.Button.cancel(),
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
