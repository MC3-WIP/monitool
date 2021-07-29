//
//  TaskListView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 29/07/21.
//

import SwiftUI

struct TaskListView: View {
	@ObservedObject var viewModel = TaskListViewModel()

    var body: some View {
		VStack {
			List {
				ForEach(viewModel.tasks) { task in
					Text(task.name)
				}
				.onDelete(perform: viewModel.delete)
			}
			Spacer()
			Button(action: {
				let task = Task(name: "Test \(viewModel.tasks.count)", repeated: [true])
				viewModel.add(task)
			}, label: {
				Text("Add Task")
			})
		}

    }

}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
		TaskListView()
    }
}
