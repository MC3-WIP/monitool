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
                ForEach(taskListViewModel.taskLists) { task in
                    TaskListRow(task: task)
                }
                .onDelete(perform: taskListViewModel.delete)
            }
            .navigationBarTitle("Task List", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showSheetView.toggle()
                                    }) {
                                        Image(systemName: "plus.circle")
                                    }
            )
            //            .toolbar {
            //                AddTaskButton()
            //            }
        }
        .sheet(isPresented: $showSheetView) {
            AddTaskView(showSheetView: self.$showSheetView)
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
    
    //    @ViewBuilder func AddTaskButton() -> some View {
    //        NavigationLink(destination: AddTaskView()) {
    //            Image(systemName: "plus.circle")
    //        }
    //    }
}

struct TaskListTabItem_Previews: PreviewProvider {
    static var previews: some View {
        PhoneLayout(selectedTab: .taskList)
    }
}
