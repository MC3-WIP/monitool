//
//  TaskManagerDetailView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 13/08/21.
//

import SwiftUI

struct TaskManagerDetailView: View {
	@Environment(\.presentationMode) var presentationMode

	let taskID: String
	@State var title: String
	@State var description: String

	@State private var repeatPopover = false
	@State var showImagePicker = false

	@State var sourceType: UIImagePickerController.SourceType = .camera
	@State var image: UIImage?

	@ObservedObject var taskListViewModel: TaskListViewModel = .shared

	init(task: TaskList) {
		taskID 			= task.id
		_title 			= State(wrappedValue: task.name)
		_description 	= State(wrappedValue: task.desc ?? "")
	}

	var body: some View {
		VStack {
			VStack {
				TextField("Task Title", text: $title)
				Divider()
				TextField("Task Description", text: $description)
				Divider()
				HStack {
					Text("Repeat")
					Spacer()
					Image(systemName: "chevron.right")
						.foregroundColor(.gray)
				}
				.onTapGesture {
					repeatPopover = true
				}
				.padding(.top, 36.0)
				Divider()
			}
			.padding()

			NoSeparatorList {
				VStack {
					HStack {
						Text("Add Photo Reference")
						Spacer()
						Button {
							self.showImagePicker.toggle()
							self.sourceType = .camera
						} label: {
							Image(systemName: "camera")
								.foregroundColor(AppColor.accent)
						}
					}
					.padding()
					.sheet(isPresented: $showImagePicker) {
						ImagePicker(sourceType: self.sourceType) { image in
							self.image = image
						}
					}
				}
			}
		}
		.navigationBarTitle("Task List", displayMode: .inline)
		.toolbar {
			Button("Done") {
				taskListViewModel.update(
					id: taskID,
					name: title,
					desc: description,
					repeated: [true]
				)
				presentationMode.wrappedValue.dismiss()
			}
		}
		.accentColor(AppColor.accent)
	}
}

struct TaskListManagerView_Previews: PreviewProvider {
    static var previews: some View {
        TaskManagerDetailView(task: TaskList(name: "hehe"))
    }
}
