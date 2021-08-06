//
//  AddEmployeeSheetView.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 02/08/21.
//

import SwiftUI

struct AddEmployeeSheetView: View {
    var sheetType: String
    @Environment(\.presentationMode) var presentationMode
    @State var employeeName: String = ""
    @State var employeePin = Employee.Helper.generatePIN()
    @State var taskName = ""
    @State var taskDesc = ""
    @State var taskRepeated = []
    @State var taskPhotoReference: [String]? = []
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
                                Text("Repeat")
                            }
                        }
                    }.listStyle(GroupedListStyle())
                }.navigationTitle("Add Task").navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button("Cancel", action: {presentationMode.wrappedValue.dismiss()}), trailing: Button("Add", action: {
                    if taskName.count != 0{
                        presentationMode.wrappedValue.dismiss()
                        let task = Task(name: taskName, description: taskDesc, photoReference: taskPhotoReference)
                        taskViewModel.add(task)
                    }
                }))
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddEmployeeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmployeeSheetView(sheetType: "")
    }
}
