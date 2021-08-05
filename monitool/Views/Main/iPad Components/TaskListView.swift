//
//  TaskList.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct TaskListView: View {
	@StateObject var viewModel = TaskViewModel()
	@Binding var filter: TaskStatus?
	@ObservedObject var role: RoleService = .shared

	var filteredData: [Task] {
		if let filter = filter {
			return viewModel.tasks.filter { task in
				task.status == filter
			}
		}
		return viewModel.tasks
	}

	var body: some View {
		List {
			ForEach(filteredData) { task in
				NavigationLink(
					destination: TaskDetailView()) {
					TaskListRow(task: task)
				}
			}
			.onDelete(perform: viewModel.delete)
		}
		.navigationTitle(filter?.rawValue ?? "Task Manager")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			if role.isOwner {
				Button {
					// PopOver
				} label: {
					Image(systemName: "plus.circle")
				}
			}
		}
	}

	@ViewBuilder
	func TaskListRow(task: Task) -> some View {
		HStack {
			VStack(alignment: .leading) {
				Text(task.name)
					.font(.headline)
				Text(task.status.rawValue)
					.font(.subheadline)
					.foregroundColor(.gray)
			}
		}
		.padding(8)
	}
}

struct TaskList_Previews: PreviewProvider {
	static var previews: some View {
		TaskListView(filter: .constant(.ongoing ))
	}
}
