//
//  TaskListView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 29/07/21.
//

import SwiftUI

struct TaskListTabItem: View {
	//	@ObservedObject var viewModel = TaskListViewModel()

	var body: some View {
		NavigationView {
			List {
				Section {
					ForEach(1..<5) { index in
						Text("Menu \(index)")
					}
				}
			}
			.toolbar(content: {
				Button(action: {
					print("Add Task")
				}, label: {
					Image(systemName: "plus.circle")
				})
			})
			.listStyle(InsetGroupedListStyle())
			.navigationTitle("Task List")
		}
		.tabItem {
			Image(systemName: "list.number")
			Text("Task List")
		}
	}
}

struct TaskListView_Previews: PreviewProvider {
	static var previews: some View {
		ForEach(["iPhone 12"], id: \.self) { device in
			TaskListTabItem()
				.previewDevice(PreviewDevice(rawValue: device))
				.previewDisplayName(device)
		}
	}
}
