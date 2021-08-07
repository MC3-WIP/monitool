//
//  TodayListView.swift
//  monitool
//
//  Created by Mac-albert on 07/08/21.
//

import SwiftUI

struct TodayListView: View {
	@StateObject var taskDetailViewModel: TaskDetailViewModel
	@ObservedObject var role: RoleService = .shared

	init(task: Task) {
		_taskDetailViewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
	}

	var body: some View {
		VStack {
			ScrollView {
				HStack {
					LeftCollumn()
					RightCollumn()
				}
			}
			HStack {
				Spacer()
					.frame(minWidth: 0, maxWidth: .infinity)
				Button("Submit") {
					// Submit Task
				}.buttonStyle(PrimaryButtonStyle())
			}
			.padding(36)
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
