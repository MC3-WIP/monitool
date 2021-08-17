//
//  HistoryView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct HistoryTabItem: View {
	@StateObject private var taskViewModel = TaskViewModel()
	private let dateHelper = DateHelper()

	private let min2Day = Calendar.current.date(byAdding: .day, value: -2, to: Date())

	init() {
		UITableViewHeaderFooterView.appearance().backgroundView = .init()
	}

	var body: some View {
		NavigationView {
			List {
				Section(header: sectionHeader(title: "Today")){
					ForEach(taskViewModel.tasks, id: \.id){ task in
						if isToday(task) {
							HistoryRow(task: task)
						}
					}
				}
				.textCase(.none)
				.listRowBackground(AppColor.primaryForeground)

				Section(header: sectionHeader(title: "Yesterday")){
					ForEach(taskViewModel.tasks, id: \.id){ task in
						if isYesterday(task) {
							HistoryRow(task: task)
						}
					}
				}.textCase(.none)

				Section(header: sectionHeader(title: dateHelper.getStringFromDate(date: min2Day!))) {
					ForEach(taskViewModel.tasks, id: \.id){ task in
						if isBeyondYesterday(task) {
							HistoryRow(task: task)
						}
					}
				}.textCase(.none)
			}
			.listStyle(PlainListStyle())
			.navigationTitle("History")
		}
		.tabItem {
			Image(systemName: "clock")
			Text("History")
		}
	}

	private func isToday(_ task: Task) -> Bool {
		dateHelper.getNumDays(first: Date(), second: task.createdAt) == 0 && task.status.rawValue == "Completed"
	}

	private func isYesterday(_ task: Task) -> Bool {
		dateHelper.getNumDays(first: task.createdAt, second: Date()) == 1 && task.status.rawValue == "Completed"
	}

	private func isBeyondYesterday(_ task: Task) -> Bool {
		dateHelper.getNumDays(first: task.createdAt, second: Date()) == 2 && task.status.rawValue == "Completed"
	}
}

// MARK: View Builders
extension HistoryTabItem {
	@ViewBuilder private func sectionHeader(title: String) -> some View {
		Text(title)
			.font(.title)
			.foregroundColor(.black)
			.fontWeight(.bold)
			.padding(.top, 10.0)
	}
}

struct HistoryTabItem_Previews: PreviewProvider {
	static var previews: some View {
		HistoryTabItem()
	}
}
