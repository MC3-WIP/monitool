//
//  TaskListTabItem.swift
//  monitool
//
//  Created by Christianto Budisaputra on 12/08/21.
//

import SwiftUI

struct TaskListTabItem: View {
	@State var tasks: [TaskList] = [
		TaskList(name: "Alpha"),
		TaskList(name: "Bravo"),
		TaskList(name: "Charlie"),
		TaskList(name: "Delta")
	]

	var body: some View {
		NavigationView {
			List(tasks) { task in
				TaskListRow(task: task)
			}
			.navigationBarTitle("Task List", displayMode: .inline)
			.toolbar {
				AddTaskButton()
			}
		}
		.tabItem {
			Image(systemName: "text.badge.plus")
			Text("Task List")
		}
	}
}

extension TaskListTabItem {
	@ViewBuilder func TaskListRow(task: TaskList) -> some View {
		Text(task.name)
			.padding(.vertical, 12)
	}

	@ViewBuilder func AddTaskButton() -> some View {
		NavigationLink(destination: AddTaskView()) {
			Image(systemName: "plus.circle")
		}
	}
}

struct TaskListTabItem_Previews: PreviewProvider {
	static var previews: some View {
		PhoneLayout(selectedTab: .taskList)
	}
}
