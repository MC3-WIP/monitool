//
//  HistoryView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import SwiftUI

struct HistoryView: View {
	@StateObject private var taskViewModel = TaskViewModel()

	init() {
		UITableView.appearance().backgroundColor = .clear
	}

	var body: some View {
		List {
			ForEach(0 ..< 6) { index in
				if taskViewModel.historiesPerDay[index].count == 0 {
					EmptyView()
				} else {
					HistoriesSection(histories: taskViewModel.historiesPerDay[index])
						.padding(.vertical, 5)
				}
			}
		}
		.navigationBarTitle("History", displayMode: .inline)
		.listStyle(InsetGroupedListStyle())
	}
}

struct HistoriesSection: View {
	private let device = UIDevice.current.userInterfaceIdiom
	private let dateHelper = DateHelper()

	var histories: [Task]
	var day: String

	init(histories: [Task]) {
		self.histories = histories

		let dayGap = dateHelper.getNumDays(first: histories[0].createdAt, second: Date())

		if dayGap == 0 {
			day = "Today"
		} else if dayGap == 1 {
			day = "Yesterday"
		} else {
			day = dateHelper.getStringFromDate(date: histories[0].createdAt)
		}
	}

	var body: some View {
		Section(
			header: Text(day)
				.font(.title.bold())
				.foregroundColor(AppColor.primaryBackground)
		) {
			ForEach(histories, id: \.id) { history in
				if device == .pad {
					NavigationLink(destination: HistoryTaskDetailView(task: history)) {
						HistoryRow(task: history)
					}
					.listRowBackground(AppColor.lightAccent)
				} else if device == .phone {
					NavigationLink(destination: HistoryDetail(history: history)) {
						HistoryRow(task: history)
					}
					.listRowBackground(AppColor.lightAccent)
				}
			}
		}
		.textCase(.none)
		.listStyle(PlainListStyle())
		.navigationTitle("History")
	}
}

struct HistoryView_Previews: PreviewProvider {
	static var previews: some View {
		HistoryView()
	}
}
