//
//  EmployeeView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 29/07/21.
//

import SwiftUI

class EmployeeViewModel: ObservableObject {
	@Published var employees = [Employee]()


}

struct EmployeeList: View {
	@ObservedObject var viewModel = EmployeeViewModel()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EmployeeList_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeList()
    }
}
