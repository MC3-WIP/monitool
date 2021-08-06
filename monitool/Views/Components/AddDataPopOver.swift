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
    @State var taskPhotoReference: [String]? = []
    @State var days = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    @State var selectedDays: [String] = []
    @ObservedObject var employeeViewModel = EmployeeListViewModel()
    @ObservedObject var taskViewModel = TaskViewModel()
    
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
                .navigationBarItems(leading: Button("Cancel", action: {presentationMode.wrappedValue.dismiss()}), trailing: Button("Add", action: {
                    if employeeName.count != 0{
                        presentationMode.wrappedValue.dismiss()
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
                        }
                    }.listStyle(GroupedListStyle())
                }.navigationTitle("Add Task").navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("Add", action: {
                    if taskName.count != 0{
                        self.presentationMode.wrappedValue.dismiss()
                        let task = Task(name: taskName, description: taskDesc, photoReference: taskPhotoReference, repeated: taskRepeated)
                        taskViewModel.add(task)
                    }
                }).foregroundColor(AppColor.accent))
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddEmployeeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddDataPopOver(sheetType: "")
    }
}
