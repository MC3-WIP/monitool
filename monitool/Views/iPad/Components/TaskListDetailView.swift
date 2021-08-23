//
//  TaskListDetailView.swift
//  monitool
//
//  Created by Scaltiel Gloria on 06/08/21.
//

import SwiftUI

struct TaskListDetailView: View {
    @State var taskTitle: String = ""
    @State var description: String = ""
    @State private var repeatPopover = false
    @State var showImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var image: UIImage?
	@State var taskRepeated = Task.defaultRepetition
    @State private var showActionSheet = false

    var body: some View {
        // NavigationView {
            VStack {
                List {
                        HStack(spacing: 70) {
                            Text("Title")
                            TextField("Buka Gerbang Toko", text: $taskTitle)
                        }
                        HStack(spacing: 16) {
                            Text("Description")
                            TextField("Input description here", text: $description)
                        }
                    HStack {
                        Button("Repeat") {
                            repeatPopover = true
                        }
                        .popover(isPresented: $repeatPopover) {
                            RepeatSheetView(repeated: $taskRepeated, isPresented: $repeatPopover)
                                .frame(width: 400, height: 400)
                        }
                        Spacer()
                        Button {
                            repeatPopover = true
						} label: {
                            HStack {
								Text(TaskHelper.convertRepetition(taskRepeated, simplified: true))
                                Image(systemName: "chevron.right")
                            }.foregroundColor(.gray)
                        }
                    }
                }.listStyle(DefaultListStyle())
                .frame(height: 200.0)
                NoSeparatorList {
                    VStack {
                        Text("Photo Reference")
							.font(.title2.weight(.semibold))
							.foregroundColor(.black)
							.padding(.leading)
							.frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                        Button {
                            self.showActionSheet.toggle()
						} label: {
                            if image != nil {
                            Image(uiImage: image!)
                                .resizable()
                                .frame(width: 140, height: 140, alignment: .center)
                                .clipShape(Rectangle())
                                .padding(.leading, 10.0)
                        }
                            Image("camera")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                .padding(.leading)

                        }
                            Spacer()
                        }.sheet(isPresented: $showImagePicker) {
                            ImagePicker(sourceType: self.sourceType) { image in
                                self.image = image
                            }
                        }
                        .actionSheet(isPresented: $showActionSheet) {() -> ActionSheet in
                            ActionSheet(
								title: Text("Choose mode"),
								message: Text("Please choose your preferred mode to add a photo reference"),
								buttons: [ActionSheet.Button.default(Text("Camera"),
								action: {
                                self.showImagePicker.toggle()
                                self.sourceType = .camera
                            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                self.showImagePicker.toggle()
                                self.sourceType = .photoLibrary
                            }), ActionSheet.Button.cancel()])

                        }
                    }
                }
            }.navigationTitle("Task List").navigationBarTitleDisplayMode(.inline)
        // }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TaskListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListDetailView()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
    }
}
