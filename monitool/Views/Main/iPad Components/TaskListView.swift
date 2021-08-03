//
//  TaskList.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct TaskListView: View {
	@StateObject var viewModel = TaskListViewModel()
	@Binding var filter: TaskStatus?
	@ObservedObject var role: RoleService = .shared

	let data = [
		Task(name: "Alpha", status: .ongoing),
		Task(name: "Bravo", status: .ongoing),
		Task(name: "Charlie", status: .waitingEmployeeReview),
		Task(name: "Delta", status: .waitingEmployeeReview),
		Task(name: "Echo", status: .waitingOwnerReview),
		Task(name: "Foxtrot", status: .waitingOwnerReview),
		Task(name: "Golf", status: .revise),
		Task(name: "Hotel", status: .revise),
		Task(name: "India", status: .completed),
		Task(name: "Juliett", status: .completed),
	]

	var filteredData: [Task] {
		if let filter = filter {
			return data.filter { task in
				task.status == filter
			}
		}
		return data
	}

	var body: some View {
		List {
			ForEach(filteredData) { task in
				NavigationLink(
					destination: Text("Destination")) {
					TaskListRow(task: task)
				}
			}
			.onDelete(perform: { _ in
				print("Hello there!")
			})
		}
		.navigationTitle(filter?.title ?? "Task Manager")
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
				Text(task.status.title)
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
