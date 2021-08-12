//
//  AddTaskView.swift
//  monitool
//
//  Created by Scaltiel Gloria on 12/08/21.
//

import SwiftUI

struct AddTaskView: View {
	@State var taskTitle: String = ""
	@State var description: String = ""
	@State private var repeatPopover = false
	@State var showImagePicker: Bool = false
	@State var sourceType: UIImagePickerController.SourceType = .camera
	@State var image: UIImage?
	@State var employeeName: String = ""
	@State var employeePin = Employee.Helper.generatePIN()
	@ObservedObject var employeeViewModel = EmployeeListViewModel()
	var body: some View {
		VStack {
			VStack {
				TextField("Task Title", text: $taskTitle)
				Divider()
				TextField("Task Description", text: $description)
				Divider()
				HStack {
					Button("Repeat") {
						repeatPopover = true
					}
					Spacer()
					Button {
						repeatPopover = true
					} label: {
						Image(systemName: "chevron.right")
							.foregroundColor(.gray)
					}
				}
				.padding(.top, 36.0)
				Divider()
			}
			.padding()

			NoSeparatorList{
				VStack{
					HStack{
						Text("Add Photo Reference").foregroundColor(.black).padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
						Spacer()
						Button(action: {
							self.showImagePicker.toggle()
							self.sourceType = .camera

						}) {
							Image(systemName: "camera").foregroundColor(Color(hex: "4EB0AB"))

						}
						Spacer()
					}.sheet(isPresented: $showImagePicker) {
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
