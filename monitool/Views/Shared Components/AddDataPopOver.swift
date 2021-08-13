//
//  AddEmployeeSheetView.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 02/08/21.
//

import SwiftUI

struct AddDataPopOver: View {
    var sheetType: String
    @Environment(\.presentationMode) var presentationMode
    @State private var repeatPopover = false
    @State var employeeName: String = ""
    @State var employeePin = Employee.Helper.generatePIN()
    @State var taskName = ""
    @State var taskDesc = ""
    @State var taskRepeated = [false, false, false, false, false, false, false]
    @State var taskPhotoReference: String?
    @State var days = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    @State var selectedDays: [String] = []
    @ObservedObject var employeeViewModel = EmployeeListViewModel()
    @ObservedObject var taskViewModel = TaskViewModel()
    @Binding var showingPopOver: Bool
    
    @State var showImagePicker: Bool = false
    @State private var showActionSheet = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var image: UIImage?
    
    var body: some View {
        NavigationView {
            if sheetType == "Employee" {
                VStack {
                    List {
                        Section(header: Color.clear
                                    .frame(width: 0, height: 0)
                                    .accessibilityHidden(true)) {
                            HStack() {
                                Text("Name")
                                TextField("", text: $employeeName).multilineTextAlignment(.trailing)
                            }
                            HStack() {
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
                            HStack() {
                                Text("Title")
                                TextField("", text: $taskName).multilineTextAlignment(.trailing)
                            }
                            HStack() {
                                Text("Description")
                                TextEditor(text: $taskDesc).multilineTextAlignment(.trailing)
                            }
                            HStack() {
                                Button("Repeat") {
                                    repeatPopover = true
                                }
                                .popover(isPresented: $repeatPopover) {
                                    RepeatSheetView(repeated: $taskRepeated, selectedDays: $selectedDays).frame(width: 400, height: 400)
                                }
                                Spacer()
                                Button(action: {
                                    repeatPopover = true
                                }) {
                                    HStack() {
                                        if selectedDays.count != 0 {
                                            if selectedDays.count == 7 {
                                                Text("Everyday")
                                            } else {
                                                ForEach(selectedDays, id:\.self) { day in
                                                    Text(day)
                                                }
                                            }
                                        }
                                        Image(systemName: "chevron.right").foregroundColor(.gray)
                                    }
                                }
                            }.foregroundColor(Color.black)
                            HStack() {
                                Button("Add Photo Reference") {
                                    self.showActionSheet.toggle()
                                }.sheet(isPresented: $showImagePicker) {
                                    ImagePicker(sourceType: self.sourceType) { image in
                                        self.image = image
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
                        let task = Task(name: taskName, description: taskDesc, photoReference: taskPhotoReference, repeated: taskRepeated)
                        let taskList = TaskList(name: taskName, desc: taskDesc, repeated: taskRepeated, photoReference: taskPhotoReference)
                        if let image = image {
                            taskViewModel.add(task, taskList, photo: image, id: UUID().uuidString)
                        }
                        else{
                            taskViewModel.add(task, taskList, id: UUID().uuidString)
                        }
                    }
                }).foregroundColor(AppColor.accent))
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
//
//struct AddEmployeeSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDataPopOver(sheetType: "")
//    }
//}
