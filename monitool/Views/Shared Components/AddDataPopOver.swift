//
//  AddEmployeeSheetView.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 02/08/21.
//

import SwiftUI

struct AddDataPopOver: View {
    var sheetType: String
    @State private var device = UIDevice.current.userInterfaceIdiom
    @State private var repeatPopover = false
    @State var employeeName: String = ""
    @State var employeePin = Employee.Helper.generatePIN()
    @State var taskName = ""
    @State var taskDesc = "Description"
    @State var taskRepeated = Task.defaultRepetition
    @State var taskPhotoReference: String?
    @ObservedObject var employeeViewModel: EmployeeListViewModel = .shared
    @ObservedObject var taskViewModel = TaskViewModel()
    @Binding var showingPopOver: Bool

    @State var showImagePicker: Bool = false
    @State private var showActionSheet = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var image: UIImage?

    @State var id = UUID().uuidString

    var body: some View {
        NavigationView {
            if sheetType == "Employee" {
                VStack {
                    List {
                        Section(header: Color.clear
                                    .frame(width: 0, height: 0)
                                    .accessibilityHidden(true)) {
                            HStack {
                                Text("Name")
                                TextField("", text: $employeeName).multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("Pin")
                                Spacer()
                                Text(employeePin)
                            }
                        }
                    }.listStyle(GroupedListStyle())
                }.navigationTitle("Add Employee").navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button("Cancel", action: {
                    showingPopOver = false
                }), trailing: Button("Add", action: {
                    if employeeName.count != 0 {
                        showingPopOver = false
                        let employee = Employee(name: employeeName, pin: employeePin)
                        employeeViewModel.add(employee)
                    }
                }))
            } else {
                VStack {
                    List {
                        Section(header: Color.clear
                                    .frame(width: 0, height: 0)
                                    .accessibilityHidden(true)) {
                            HStack {
                                Text("Title")
                                TextField("Title", text: $taskName).multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("Description")
                                TextEditor(text: $taskDesc).multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Button("Repeat") {
                                    repeatPopover = true
                                }
                                .popover(isPresented: $repeatPopover) {
                                    if device == .pad {
                                        RepeatSheetView(repeated: $taskRepeated, isPresented: $repeatPopover)
                                            .frame(width: 400, height: 400)
                                    } else {
                                        RepeatSheetView(repeated: $taskRepeated, isPresented: $repeatPopover)
                                            .frame(alignment: .top)
                                    }
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
                            }.foregroundColor(Color.black)
                            HStack {
                                Button("Add Photo Reference") {
                                    self.showActionSheet.toggle()
                                }.sheet(isPresented: $showImagePicker) {
                                    ImagePicker(sourceType: self.sourceType) { image in
                                        self.image = image
                                    }
                                }
                                .actionSheet(isPresented: $showActionSheet) { () -> ActionSheet in
                                    ActionSheet(
                                        title: Text("Choose mode"),
                                        message: Text("Please choose your preferred mode to set your profile image"),
                                        buttons: [
                                            ActionSheet.Button.default(
                                                Text("Camera"),
                                                action: {
                                                    self.showImagePicker.toggle()
                                                    self.sourceType = .camera
                                                }
                                            ),
                                            ActionSheet.Button.default(
                                                Text("Photo Library"),
                                                action: {
                                                    self.showImagePicker.toggle()
                                                    self.sourceType = .photoLibrary
                                                }
                                            ),
                                            ActionSheet.Button.cancel()]
                                    )
                                }
                                Spacer()
                                Image(systemName: "camera").foregroundColor(AppColor.accent)
                            }.foregroundColor(Color.black)
                            if image != nil {
                                Image(uiImage: image!)
                                    .resizable()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .clipShape(Rectangle())
                                    .padding(.bottom, 10.0)
                            }
                        }
                    }.listStyle(GroupedListStyle())
                }.navigationTitle("Add Task").navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("Add", action: {
                    if taskName.count != 0 {
                        showingPopOver = false
                        let task = Task(
                            name: taskName,
                            description: taskDesc,
                            photoReference: taskPhotoReference,
                            parentId: id
                        )
                        let taskList = TaskList(
                            name: taskName,
                            desc: taskDesc,
                            repeated: taskRepeated,
                            photoReference: taskPhotoReference
                        )
                        if let image = image {
                            taskViewModel.add(task, taskList, photo: image, id: id)
                        } else {
                            taskViewModel.add(task, taskList, id: id)
                        }
                    }
                }).foregroundColor(AppColor.accent))
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .accentColor(AppColor.accent)
    }
}
