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
	@State private var showActionSheet = false
	@Binding var showSheetView: Bool

	@ObservedObject var taskListViewModel: TaskListViewModel = .shared
	@State var selectedDays: [String] = []
	@State var taskRepeated = [false, false, false, false, false, false, false]

	var body: some View {
		NavigationView {
			VStack {
				VStack {
					TextField("Task Title", text: $taskTitle)
					Divider()
					TextField("Task Description", text: $description)
					Divider()
					HStack {
						Text("Repeat")
						Spacer()
						if selectedDays.count != 0 {
							if selectedDays.count == 7 {
								Text("Everyday").foregroundColor(.gray)
							} else {
								ForEach(selectedDays, id: \.self) { day in
									Text(day).foregroundColor(.gray)
								}
							}
						}
						Image(systemName: "chevron.right")
							.foregroundColor(.gray)
					}
					.onTapGesture {
						repeatPopover = true
					}.sheet(isPresented: $repeatPopover) {
						RepeatSheetView(repeated: $taskRepeated, selectedDays: $selectedDays)
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
								showActionSheet.toggle()
							} label: {
								Image(systemName: "camera")
									.foregroundColor(AppColor.accent)
							}
						}
						.padding()
						.sheet(isPresented: $showImagePicker) {
							ImagePicker(sourceType: sourceType) { image in
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
					if let image = image {
						Image(uiImage: image)
							.resizable()
							.frame(width: 250, height: 250, alignment: .center)
							.clipShape(Rectangle())
							.padding(.leading, -100.0)
					}
				}
			}
			.navigationBarTitle("Add Task List", displayMode: .inline)
			.navigationBarItems(leading: cancelButton(), trailing: addButton())
		}
	}
}

extension AddTaskView {
	@ViewBuilder func cancelButton() -> some View {
		Button("Cancel") {
			self.showSheetView = false
		}.foregroundColor(AppColor.accent)
	}

	@ViewBuilder func addButton() -> some View {
		Button("Add") {
			let task = TaskList(name: taskTitle)
			taskListViewModel.add(task)
			presentationMode.wrappedValue.dismiss()
		}.foregroundColor(AppColor.accent)
	}
}

struct AddTaskView_Previews: PreviewProvider {
	static var previews: some View {
		AddTaskView(showSheetView: .constant(false))
	}
}
