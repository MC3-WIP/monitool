//
//  AddEmployeeSheetView.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 02/08/21.
//

import SwiftUI

struct AddEmployeeSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var employeeName: String = ""
    @State var employeePin = Employee.Helper.generatePIN()
    @ObservedObject var employeeViewModel = EmployeeListViewModel()
    
    var body: some View {
        NavigationView {
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
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddEmployeeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmployeeSheetView()
    }
}
