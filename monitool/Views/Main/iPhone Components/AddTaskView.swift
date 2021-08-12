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
       // NavigationView {
            VStack {
                List() {
                        HStack(spacing: 70) {
                            TextField("Task Title", text: $taskTitle)
                        }
                        HStack(spacing: 16) {
                            TextField("Task Description", text: $description)
                        }
                    HStack {
                        Button("Repeat") {
                            repeatPopover = true
                        }
//                        .popover(isPresented: $repeatPopover) {
//                                RepeatSheetView().frame(width: 400, height: 400)
//                            }
                        Spacer()
                        Button(action: {
                            repeatPopover = true
                        }) {
                            Image(systemName: "chevron.right").foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 40.0)
                }.listStyle(DefaultListStyle())
                .frame(height: 200.0)
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
            }.navigationTitle("Task List").navigationBarTitleDisplayMode(.inline)
        //}.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarItems(leading: Button("Cancel", action: {
            //showingPopOver = false
            print("cancel")
        }), trailing: Button("Add", action: {
            print("add")
            //if employeeName.count != 0 {
                //showingPopOver = false
//                let employee = Employee(name: employeeName, pin: employeePin)
//                employeeViewModel.add(employee)
        
        }))
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
