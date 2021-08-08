//
//  TodayListView.swift
//  monitool
//
//  Created by Mac-albert on 07/08/21.
//

import SwiftUI

struct TodayListView: View {
	@StateObject var todayListViewModel: TodayListViewModel
	@ObservedObject var role: RoleService = .shared
	@ObservedObject var employeeRepository: EmployeeRepository = .shared
	@State var isEmployeePickerPresenting = false

	let employeeDummy = [
		Employee(name: "Alpha"),
		Employee(name: "Bravo"),
		Employee(name: "Charlie"),
		Employee(name: "Delta")
	]

	init(task: Task) {
		_todayListViewModel = StateObject(wrappedValue: TodayListViewModel(task: task))
	}

	var body: some View {
		VStack {
			ScrollView {
				HStack(spacing: 24) {
					LeftCollumn()
					RightCollumn()
				}
                .frame(height: 680)
			}
			HStack(spacing: 24) {
				Spacer()
					.frame(minWidth: 0, maxWidth: .infinity)
				Button("Submit") {
					// Submit Task
				}.buttonStyle(PrimaryButtonStyle())
			}
			.padding()
		}
		.navigationTitle("Today List")
	}
}

// MARK: - Previews
struct TodayListView_Previews: PreviewProvider {
	static var previews: some View {
		TodayListView(task: Task(name: "Hehe"))
			.previewDevice("iPad Pro (12.9-inch) (5th generation)")
			.previewLayout(.fixed(width: 1112, height: 834))
	}
}
