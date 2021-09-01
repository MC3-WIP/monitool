//
//  TaskListTabItem.swift
//  monitool
//
//  Created by Christianto Budisaputra on 12/08/21.
//

import SwiftUI

struct TaskListTabItem: View {
    @State var showSheetView = false
    @State var isDisabled = false

    @StateObject var taskListViewModel: TaskListViewModel = .shared

    var body: some View {
        NavigationView {
            Group {
                if taskListViewModel.taskLists.isEmpty {
                    Image("EmptyTask")
                        .resizable()
                        .scaledToFit()
                        .padding(36)
                } else {
                    content
                }
            }
            .navigationBarTitle("Task List", displayMode: .inline)
            .toolbar {
                AddTaskButton()
            }
        }
        .popover(isPresented: $showSheetView) {
            AddDataPopOver(sheetType: "Task", showingPopOver: $showSheetView)
        }
        .tabItem {
            Image(systemName: "text.badge.plus")
            Text("Task List")
        }
        .disabled(isDisabled)
        .accentColor(isDisabled ? .gray : AppColor.accent)
    }

    private var content: some View {
        List {
            ForEach(taskListViewModel.taskLists, id: \.id) { task in
                NavigationLink(destination: EditTaskListView(task: task, isDisabled: $isDisabled)) {
                    TaskListRow(task: task)
                }
            }.onDelete(perform: taskListViewModel.delete)
        }
    }
}

extension TaskListTabItem {
    @ViewBuilder func TaskListRow(task: TaskList) -> some View {
        VStack(alignment: .leading) {
            Text(task.name)
                .font(.headline)
            if let repetition = task.repeated {
                Text(TaskHelper.convertRepetition(repetition, simplified: true))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }.padding(.vertical, 12)
    }

    @ViewBuilder func AddTaskButton() -> some View {
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
