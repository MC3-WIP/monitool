//
//  EmployeeListView.swift
//  monitool
//
//  Created by Devin Winardi on 29/07/21.
//
import SwiftUI

struct EmployeeListView: View {
    @ObservedObject var viewModel = EmployeeListViewModel()

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.employees) { employee in
                    Text(employee.name)
                }
                .onDelete(perform: viewModel.delete)
            }
            Spacer()
            Button(action: {
                let employee = Employee(name: "Test \(viewModel.employees.count)", pin: "1111")
                viewModel.add(employee)
            }, label: {
                Text("Add Employee")
            })
        }

    }

}

struct EmployeeListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListView()
    }
}
