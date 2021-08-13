//
//  PhotoComponent.swift
//  monitool
//
//  Created by Devin Winardi on 30/07/21.
//

import Foundation
import SwiftUI

struct PhotoComponent: View {
    
    @State var showImagePicker: Bool = false
    @State private var showActionSheet = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var image: UIImage?
	  
    @Binding var editMode: EditMode
  
    @ObservedObject var storageService = StorageService()
    
    var body: some View{
        VStack{
            if image == nil {
                Image("profile")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                    .padding(.bottom, 10.0)
            } else {
                Image(uiImage: image!)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                    .padding(.bottom, 10.0)
            }
            if editMode.isEditing {
              UploadButton()
            }
        }
    }

	@ViewBuilder
	func UploadButton() -> some View {
		Button("Upload photo") {
			self.showActionSheet.toggle()
		}
		.sheet(isPresented: $showImagePicker) {
			ImagePicker(sourceType: self.sourceType) { image in
				self.image = image
        storageService.upload(image: self.image!, path: "profile")
			}
		}
		.actionSheet(isPresented: $showActionSheet) {() -> ActionSheet in
			ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
				self.showImagePicker.toggle()
				self.sourceType = .camera
			}), ActionSheet.Button.default(Text("Photo Library"), action: {
				self.showImagePicker.toggle()
				self.sourceType = .photoLibrary
			}), ActionSheet.Button.cancel()])

		}
	}
}

struct PhotoComponent_Previews: PreviewProvider {
    static var previews: some View {
		PhotoComponent(editMode: .constant(EditMode.active))
    }
}

