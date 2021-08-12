//
//  TaskListView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 29/07/21.
//

import SwiftUI

struct TaskListTabItem: View {
	//	@ObservedObject var viewModel = TaskListViewModel()
    @State var isLinkActive = false
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
                    self.isLinkActive = true
				}, label: {
					Image(systemName: "plus.circle")
				})
			})
			.listStyle(InsetGroupedListStyle())
			.navigationTitle("Task List")
            .background(
                            NavigationLink(destination: AddTaskView(), isActive: $isLinkActive) {
                                //AddTaskView()
                            }
                            //.hidden()
                        )
		}.navigationBarItems(leading: Button("Cancel", action: {
            //            //showingPopOver = false
                       print("cancel")
                   }), trailing: Button("Add", action: {
                        print("add")
                        //if employeeName.count != 0 {
                            //showingPopOver = false
            //                let employee = Employee(name: employeeName, pin: employeePin)
            //                employeeViewModel.add(employee)
            //
                   }))
		.tabItem {
			Image(systemName: "list.number")
			Text("Task List")
		}
	}
}

struct TaskListView_Previews: PreviewProvider {
	static var previews: some View {
		ForEach(["iPhone 12", "iPad Air (4th generation)"], id: \.self) { device in
			TaskListTabItem()
				.previewDevice(PreviewDevice(rawValue: device))
				.previewDisplayName(device)
		}
	}
}
