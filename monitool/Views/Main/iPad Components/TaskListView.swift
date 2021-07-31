//
//  TaskList.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct TaskListView: View {
	var body: some View {
		List(1..<10) { index in
			Text("Task \(index)")
		}
		.navigationTitle("To Do List")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar(content: {
			AddTaskButton()
		})
	}

	@ViewBuilder
	func AddTaskButton() -> some View {
		Button(action: {
			print("Add Item")
		}, label: {
			Image(systemName: "plus.circle")
		})
	}
}

struct TaskList_Previews: PreviewProvider {
	static var previews: some View {
		TaskListView()
	}
}
