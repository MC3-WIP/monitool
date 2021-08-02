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
    @State var employeePin: String = ""
    @ObservedObject var viewModel = EmployeeListViewModel()
    
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
                            TextField("", text: $employeePin).multilineTextAlignment(.trailing)
                        }
                    }
                }.listStyle(GroupedListStyle())
            }.navigationTitle("Add Employee").navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Cancel", action: {presentationMode.wrappedValue.dismiss()}), trailing: Button("Add", action: {
                if employeeName != "" {
                    presentationMode.wrappedValue.dismiss()
                    let employee = Employee(name: employeeName)
                    viewModel.add(employee)
                }
                presentationMode.wrappedValue.dismiss()
            }))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddEmployeeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmployeeSheetView()
    }
}
