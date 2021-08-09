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
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

	init(task: Task) {
		_todayListViewModel = StateObject(wrappedValue: TodayListViewModel(task: task))
	}

	var body: some View {
		VStack {
//			ScrollView {
				HStack(spacing: 24) {
					LeftColumn()
					RightColumn()
				}
				.padding(.top)
//			}
			if !role.isOwner {
				HStack(spacing: 24) {
					Spacer()
						.frame(minWidth: 0, maxWidth: .infinity)
					Button("Submit") {
						todayListViewModel.submitTask(
							pic: employeeRepository.employees[todayListViewModel.picSelection],
							notes: todayListViewModel.notesText
						)
						presentationMode.wrappedValue.dismiss()
					}.buttonStyle(PrimaryButtonStyle())
				}
				.padding(.top)
			}
		}
		.padding([.leading, .trailing, .bottom], 24)
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
