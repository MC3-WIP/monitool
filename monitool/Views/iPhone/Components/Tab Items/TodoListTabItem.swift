//
//  TaskListiPhoneView.swift
//  monitool
//
//  Created by Devin Winardi on 11/08/21.
//

import Foundation
import SwiftUI

struct TodoListTabItem: View {
    @StateObject var taskViewModel = TaskViewModel()
    @State private var selection: Set<TaskStatus> = []

    let taskStatuses: [TaskStatus] = [.todayList, .waitingEmployeeReview, .waitingOwnerReview, .revise]

    let statusIcon: [Image] = [
        Image(systemName: "list.bullet.below.rectangle"),
        Image(systemName: "person.3"),
        Image(systemName: "person.crop.circle.badge.checkmark"),
        Image(systemName: "repeat")
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(0 ..< 4) { index in
                    TasksRowView(
                        taskStatus: taskStatuses[index],
                        tasks: getFilteredTask(filter: taskStatuses[index]),
                        isExpanded: self.selection.contains(taskStatuses[index]),
                        icon: statusIcon[index]
                    )
                    .animation(Animation.easeIn)
                    .onTapGesture { self.selectDeselect(taskStatuses[index]) }
                }
            }
            .navigationTitle("To-Do List")
            .toolbar {
                NavigationLink(destination: HistoryView()) {
                    Image(systemName: "clock")
                }
            }
        }
        .tabItem {
            Image(systemName: "list.bullet.rectangle")
            Text("To-Do List")
        }
    }

    func selectDeselect(_ taskStatus: TaskStatus) {
        if selection.contains(taskStatus) {
            selection.remove(taskStatus)
        } else {
            selection.insert(taskStatus)
        }
    }

    func getFilteredTask(filter: TaskStatus) -> [Task] {
        let result = taskViewModel.tasks.filter { $0.status == filter }
        return result
    }
}

struct TasksRowView: View {
    let taskStatus: TaskStatus
    let tasks: [Task]
    let isExpanded: Bool
    let icon: Image

    var body: some View {
        HStack {
            icon.foregroundColor(AppColor.accent)
            Text(taskStatus.title).font(.headline)
            Spacer()
            Image(systemName: "chevron.down").foregroundColor(Color(hex: "#4EB0AB"))
        }
        .contentShape(Rectangle())
        .animation(.linear(duration: 0.3))
        if isExpanded {
            if tasks.count != 0 {
                ForEach(tasks) { task in
                    NavigationLink(destination: IphoneEmployeeReview(task: task)) {
                        Text(task.name)
                    }
                }
            } else {
                Text("No Task").foregroundColor(.gray)
            }
        }
    }
}

struct TodoListTabItem_Previews: PreviewProvider {
    static var previews: some View {
        TodoListTabItem()
    }
}
