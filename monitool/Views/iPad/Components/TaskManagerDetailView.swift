//
//  TaskManagerDetailView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 13/08/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct TaskManagerDetailView: View {
    @Environment(\.presentationMode) var presentationMode

    let taskID: String
    @State var title: String
    @State var description: String
    @State var repeated: [Bool]

    @State private var repeatPopover = false
    @State var showImagePicker = false
    @State var isShowingAlert = false

    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showSourceTypePopover = false
    @State var image: UIImage?
    private var imageUrl: URL?

    @Binding var isDisabled: Bool

    @ObservedObject var taskListViewModel: TaskListViewModel = .shared

    init(task: TaskList, isDisabled: Binding<Bool>) {
        taskID = task.id
        _repeated = State(wrappedValue: task.repeated ?? Task.defaultRepetition)
        _title = State(wrappedValue: task.name)
        _description = State(wrappedValue: task.desc ?? "")
        _isDisabled = isDisabled

        if let imageRef = task.photoReference, let imageUrl = URL(string: imageRef) {
            self.imageUrl = imageUrl
        }
    }

    var body: some View {
        if isDisabled {
            VStack(spacing: 12) {
                ProgressView()
                Text("Updating Changes...")
            }
        } else {
            content
        }
    }

    private var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            TextField("Task Title", text: $title)

            Divider()

            TextField("Task Description", text: $description)

            Divider()

            HStack {
                Text("Repeat")
                Spacer()
                HStack {
                    Text(TaskHelper.convertRepetition(repeated, simplified: true))
                    Image(systemName: "chevron.right")
                        .popover(isPresented: $repeatPopover) {
                            RepeatSheetView(repeated: $repeated, isPresented: $repeatPopover)
                                .frame(width: 400, height: 400)
                        }
                }.foregroundColor(.gray)
            }
            .onTapGesture {
                repeatPopover = true
            }
            .padding(.top, 36.0)

            Divider()

            HStack {
                Text("Photo Reference")
                    .font(.title3.weight(.semibold))
                    .padding(.top)

                Spacer()
            }

            HStack(spacing: 16) {
                if let imageUrl = imageUrl {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200)
                            .cornerRadius(8)
                    } else {
                        WebImage(url: imageUrl)
                            .resizable()
                            .indicator(content: { _, _ in
                                VStack(spacing: 12) {
                                    ProgressView()
                                    Text("Loading Photo Reference...")
                                }
                            })
                            .transition(.fade(duration: 0.5))
                            .scaledToFill()
                            .frame(width: 200)
                            .cornerRadius(8)
                    }
                } else if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200)
                        .cornerRadius(8)
                }

                Button {
                    showSourceTypePopover = true
                } label: {
                    VStack(spacing: 24) {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90)
                        Text("Replace Photo")
                            .font(.title3.weight(.semibold))
                    }
                    .frame(width: 200, height: 200)
                }
                .foregroundColor(AppColor.primaryForeground)
                .background(AppColor.accent)
                .cornerRadius(8)
                .popover(isPresented: $showSourceTypePopover) {
                    VStack(alignment: .leading, spacing: 12) {
                        Button {
                            showSourceTypePopover = false
                            self.sourceType = .camera
                            self.showImagePicker = true
                        } label: {
                            HStack {
                                Image(systemName: "camera")
                                    .foregroundColor(AppColor.accent)
                                Text("Take a Photo")
                            }
                        }
                        Divider()
                        Button {
                            showSourceTypePopover = false
                            self.sourceType = .photoLibrary
                            self.showImagePicker = true
                        } label: {
                            HStack {
                                Image(systemName: "photo.on.rectangle")
                                    .foregroundColor(AppColor.accent)
                                Text("Select from Camera Roll")
                            }
                        }
                    }
                    .foregroundColor(AppColor.primaryBackground)
                    .padding()
                }

                Spacer()
            }
        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: self.sourceType) { image in
                self.image = image
            }
        }
        .navigationBarTitle("Task List", displayMode: .inline)
        .toolbar {
            Button("Done") {
                taskListViewModel.update(
                    id: taskID,
                    name: title,
                    desc: description,
                    repeated: repeated
                )

                if let image = image {
                    isDisabled = true
                    taskListViewModel.updatePhotoReference(image: image, taskID: taskID) { err in
                        if let err = err {
                            print("Error uploading photo reference:", err.localizedDescription)
                            isShowingAlert.toggle()
                        }
                        isDisabled = false
                        presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .alert(isPresented: $isShowingAlert) {
            AppAlert.TaskList.failUploading
        }
        .accentColor(AppColor.accent)
    }
}

struct TaskListManagerView_Previews: PreviewProvider {
    static var previews: some View {
        TaskManagerDetailView(task: TaskList(name: "hehe"), isDisabled: .constant(false))
    }
}
