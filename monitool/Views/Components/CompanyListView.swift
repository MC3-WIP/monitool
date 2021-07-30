//
//  CompanyListView.swift
//  monitool
//
//  Created by Mac-albert on 29/07/21.
//

import Foundation
import SwiftUI

struct CompanyListView: View {
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
                let employee = Employee(name: "Test \(viewModel.employees.count)")
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
