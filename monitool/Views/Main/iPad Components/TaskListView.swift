//
//  TaskList.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct TaskListView: View {
    @State var taskName = ""
    @State var taskDesc = ""
    @State var taskRepeated = []
    @State var taskPhotoReference = []
    @State private var showingPopover = false
	@StateObject var taskViewModel = TaskViewModel()
	@Binding var filter: TaskStatus?
	@ObservedObject var role: RoleService = .shared

	var filteredData: [Task] {
		if let filter = filter {
			return taskViewModel.tasks.filter { task in
				task.status == filter
			}
		}
		return taskViewModel.tasks
	}

	var body: some View {
		List {
			ForEach(filteredData) { task in
				NavigationLink(
					destination: TaskDetailView()) {
					TaskListRow(task: task)
				}
			}
			.onDelete(perform: taskViewModel.delete)
		}
		.navigationTitle(filter?.rawValue ?? "Task List")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			if role.isOwner {
				Button("Add task") {
					showingPopover = true
                }.popover(isPresented: $showingPopover) {
                    AddDataPopOver(sheetType: "Task").frame(width: 400, height: 400)
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
