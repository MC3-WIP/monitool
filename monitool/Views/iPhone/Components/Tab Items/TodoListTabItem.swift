//
//  TaskListiPhoneView.swift
//  monitool
//
//  Created by Devin Winardi on 11/08/21.
//

import SwiftUI
import Combine

class TodoListTabItemModel: ObservableObject {
    @Published var tasks = [Task]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        TaskRepository.shared.$tasks
            .assign(to: \.tasks, on: self)
            .store(in: &cancellables)
    }
}

struct TodoListTabItem: View {
    @StateObject var viewModel = TodoListTabItemModel()
    @State var selections: Set<TaskStatus> = [.todayList]

    var body: some View {
        NavigationView {
            List {
                section(for: .todayList, icon: "list.bullet.below.rectangle")
                section(for: .waitingEmployeeReview, icon: "person.2")
                section(for: .waitingOwnerReview, icon: "person.crop.circle.badge.checkmark")
                section(for: .revise, icon: "repeat")
            }
            .navigationBarTitle("To-Do List")
            .toolbar {
                NavigationLink(destination: HistoryView()) {
                    Image(systemName: "clock")
                }
            }
        }
    }

    @ViewBuilder
    private func sectionHeader(for status: TaskStatus, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(AppColor.accent)
            Text(status.title)
            Spacer()
            Image(systemName: selections.contains(status) ? "chevron.up" : "chevron.down")
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle())
        .animation(.linear(duration: 0.3))
        .onTapGesture {
            toggleSelection(for: status)
        }
    }

    @ViewBuilder
    private func section(for status: TaskStatus, icon: String) -> some View {
        sectionHeader(for: status, icon: icon)

        if selections.contains(status) {
            if viewModel.tasks.filter({ $0.status == status }).count > 0 {
                ForEach(viewModel.tasks.filter { $0.status == status }) { task in
                    NavigationLink(destination: route(task: task, status: status)) {
                        Text(task.name)
                    }
                }
            } else {
                Text("No Task").foregroundColor(.gray)
            }
        }
    }

    private func toggleSelection(for status: TaskStatus) {
        if selections.contains(status) {
            selections.remove(status)
        } else {
            selections.insert(status)
        }
    }

    private func route(task: Task, status: TaskStatus) -> AnyView {
        switch status {
        case .todayList:
            return AnyView(IphoneTodayListView(task: task))
        case .waitingEmployeeReview:
            return AnyView(IphoneEmployeeReview(task: task))
        case .waitingOwnerReview:
            return AnyView(IphoneOwnerReview(task: task))
        case .revise:
            return AnyView(IphoneReviseView(task: task))
        default:
            return AnyView(EmptyView())
        }
    }
}

struct TodoListTabItem_Previews: PreviewProvider {
    static var previews: some View {
        PhoneLayout()
    }
}
