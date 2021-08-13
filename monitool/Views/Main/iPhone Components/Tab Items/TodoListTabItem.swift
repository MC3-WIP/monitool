//
//  TodoListTabItem.swift
//  monitool
//
//  Created by Christianto Budisaputra on 29/07/21.
//

import SwiftUI

struct TodoListTabItem: View {
	//	@ObservedObject var viewModel = TaskListViewModel()

	var body: some View {
		NavigationView {
			List {
				Section(header:
							HStack {
								Image(systemName: "largecircle.fill.circle")
								Text("To Do List")
							}
				) {
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
			Image(systemName: "list.bullet.rectangle")
			Text("To-do List")
		}
	}
}

struct TodoListTabItem_Previews: PreviewProvider {
	static var previews: some View {
		ForEach(["iPhone 12", "iPad Air (4th generation)"], id: \.self) { device in
			TodoListTabItem()
				.previewDevice(PreviewDevice(rawValue: device))
				.previewDisplayName(device)
		}
	}
}
