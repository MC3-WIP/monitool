//
//  AddTaskView.swift
//  monitool
//
//  Created by Scaltiel Gloria on 12/08/21.
//

import SwiftUI

struct AddTaskView: View {
	@Environment(\.presentationMode) var presentationMode

	@State var taskTitle: String = ""
	@State var description: String = ""

	@State private var repeatPopover = false
	@State var showImagePicker = false
	@State var sourceType: UIImagePickerController.SourceType = .camera
	@State var image: UIImage?

	@ObservedObject var taskListViewModel: TaskListViewModel = .shared

	var body: some View {
		VStack {
			VStack {
				TextField("Task Title", text: $taskTitle)
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

			NoSeparatorList{
				VStack{
					HStack{
						Text("Add Photo Reference")
						Spacer()
						Button(action: {
							self.showImagePicker.toggle()
							self.sourceType = .camera

						}) {
							Image(systemName: "camera").foregroundColor(Color(hex: "4EB0AB"))

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
		.navigationBarTitle("Add Task List", displayMode: .inline)
		.toolbar {
			Button("Add") {
				let task = TaskList(name: taskTitle)
				taskListViewModel.add(task)
				presentationMode.wrappedValue.dismiss()
			}
		}
		.accentColor(AppColor.accent)
	}
}

struct AddTaskView_Previews: PreviewProvider {
	static var previews: some View {
		AddTaskView()
	}
}
