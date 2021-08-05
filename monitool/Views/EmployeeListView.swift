//
//  EmployeeListView.swift
//  monitool
//
//  Created by Devin Winardi on 29/07/21.
//
import SwiftUI

struct EmployeeListView<Content: View>: View {
//    @ObservedObject var viewModel = EmployeeListViewModel()
	@State var employees = [Employee]()
	@Binding var isPinHidden: Bool

	let header: Content?

	init(isPinHidden: Binding<Bool>, @ViewBuilder header: () -> Content?) {
		_employees = State(initialValue: [
			Employee(name: "Alpha"),
			Employee(name: "Bravo"),
			Employee(name: "Charlie"),
			Employee(name: "Delta"),
			Employee(name: "Echo"),
			Employee(name: "Alpha"),
			Employee(name: "Bravo"),
			Employee(name: "Charlie"),
			Employee(name: "Delta"),
			Employee(name: "Echo"),
			Employee(name: "Foxtrot")
		])

		self.header = header()
		self._isPinHidden = isPinHidden
//		UITableViewHeaderFooterView.appearance().backgroundView = .init()
	}

	func add(_ employee: Employee){
		employees.append(employee)
	}

	func delete(_ offsets: IndexSet) {
		offsets.forEach { index in
			employees.remove(at: index)
		}
	}

    var body: some View {
//        VStack {
			List() {
				Section(header: header
							.textCase(.none)
							.padding(.vertical, 12)
//							.background(Color.blue)
				) {
					ForEach(employees) { employee in
						HStack {
							Text(employee.name)
							Spacer()
							Text(isPinHidden ? "****" : employee.pin)
						}
					}
					.onDelete(perform: delete)
				}
            }
//            Spacer()
//            Button(action: {
//                let employee = Employee(name: "Test \(employees.count)")
//                add(employee)
//            }, label: {
//                Text("Add Employee")
//            })
//        }
    }

}

struct EmployeeListView_Previews: PreviewProvider {
    static var previews: some View {
		EmployeeListView(isPinHidden: .constant(false)) {
			HStack {
				Text("Hello World!")
				Spacer()
				Image(systemName: Icon.employeeReview)
			}
		}
    }
}
