//
//  TaskList.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI
import Combine

// MARK: - View Model
extension TaskListView {
    class ViewModel: ObservableObject {
        @Published var tasks = [Task]()
        @ObservedObject private var repository: TaskRepository = .shared

        private var subscriptions = Set<AnyCancellable>()

        init() {
            repository.$tasks
                .assign(to: \.tasks, on: self)
                .store(in: &subscriptions)
        }

        func delete(_ indexSet: IndexSet) {
            indexSet.forEach { index in
                repository.delete(tasks[index])
            }
        }

        @ViewBuilder
        func route(_ filter: TaskStatus?, task: Task) -> some View {
            if let filter = filter {
                switch filter {
                case .todayList:
                    TodayListView(task: task)
                case .waitingEmployeeReview:
                    EmployeeReviewView(task: task)
                case .waitingOwnerReview:
                    OwnerReviewView(task: task)
                case .revise:
                    ReviseView(task: task)
                default:
                    EmptyView()
                }
            } else {
                TaskListDetailView()
            }
        }
    }
}

struct TaskListView: View {
    @State private var showingPopover = false
    @Binding var filter: TaskStatus?

    @StateObject var viewModel = ViewModel()

    @ObservedObject var role: RoleService = .shared

    var filteredData: [Task] {
        if let filter = filter {
            return viewModel.tasks.filter { task in
                task.status == filter
            }
        }
        return viewModel.tasks
    }

    private var taskIsEmpty: Bool {
        viewModel.tasks.filter({ $0.status == filter }).isEmpty
    }

    var body: some View {
        renderContent()
        .navigationBarTitle(filter?.title ?? "Task List", displayMode: .inline)
        .navigationBarItems(trailing: renderToolbar())
    }
}

// MARK: - View Builders
extension TaskListView {
    @ViewBuilder func renderToolbar() -> some View {
        if role.isOwner {
            Button("Add task") {
                showingPopover = true
            }
            .popover(isPresented: $showingPopover) {
                AddDataPopOver(
                    sheetType: "Task",
                    showingPopOver: $showingPopover
                ).frame(width: 400, height: 400)
            }
        }
    }

    @ViewBuilder func renderContent() -> some View {
        if taskIsEmpty {
            Image("EmptyTask")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 360, alignment: .center)
        } else {
            List {
                ForEach(filteredData) { task in
                    NavigationLink(
                        destination: viewModel.route(filter, task: task)) {
                        TaskListRow(task: task)
                    }
                }
                .onDelete(perform: viewModel.delete)
            }
        }
    }

    @ViewBuilder
    func TaskListRow(task: Task) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.headline)
                Text(task.status.title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }.padding(8)
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(filter: .constant(.todayList))
    }
}
