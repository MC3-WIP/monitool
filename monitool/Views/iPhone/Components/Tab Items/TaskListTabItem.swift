//
//  TaskListTabItem.swift
//  monitool
//
//  Created by Christianto Budisaputra on 12/08/21.
//

import SwiftUI

struct TaskListTabItem: View {
	@StateObject var taskListViewModel: TaskListViewModel = .shared
	@State var showSheetView = false

	var body: some View {
		NavigationView {
			List {
				ForEach(taskListViewModel.taskLists, id: \.id) { task in
					NavigationLink(destination: EditTaskListView(task: task)) {
						taskListRow(task: task)
					}
				}.onDelete(perform: taskListViewModel.delete)
			}
			.navigationBarTitle("Task List", displayMode: .inline)
			.toolbar {
				addTaskButton()
			}
		}
		.sheet(isPresented: $showSheetView) {
			AddTaskView(showSheetView: $showSheetView)
		}
		.tabItem {
			Image(systemName: "text.badge.plus")
			Text("Task List")
		}
	}
}

extension TaskListTabItem {
	@ViewBuilder func taskListRow(task: TaskList) -> some View {
		Text(task.name)
			.padding(.vertical, 12)
	}

	@ViewBuilder func addTaskButton() -> some View {
		Button {
			showSheetView.toggle()
		} label: {
			Image(systemName: "plus.circle")
		}
	}
}

struct TaskListTabItem_Previews: PreviewProvider {
	static var previews: some View {
		PhoneLayout(selectedTab: .taskList)
	}
}
