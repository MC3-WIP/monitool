//
//  TaskManagerView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 13/08/21.
//

import Combine
import SwiftUI

// MARK: - View Model
extension TaskManagerView {
    class ViewModel: ObservableObject {
        @Published var taskList = [TaskList]()

        @ObservedObject private var repository: TaskListRepository = .shared

        private var subscriptions = Set<AnyCancellable>()

        init() {
            repository.$taskLists
                .assign(to: \.taskList, on: self)
                .store(in: &subscriptions)
        }

        func delete(_ indexSet: IndexSet) {
            indexSet.forEach { index in
                repository.delete(taskList[index])
            }
        }
    }
}

struct TaskManagerView: View {
    @State private var showingPopover = false
    @State var isDisabled = false

    @StateObject var viewModel = ViewModel()

    var body: some View {
        Group {
            if viewModel.taskList.isEmpty {
                Image("EmptyTask")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 360, alignment: .center)
            } else {
                List {
                    ForEach(viewModel.taskList, id: \.name) { task in
                        NavigationLink(destination: TaskManagerDetailView(
                            task: task,
                            isDisabled: $isDisabled
                        )) {
                            TaskListRow(task: task)
                        }
                    }
                    .onDelete(perform: viewModel.delete)
                }
            }
        }
        .navigationBarTitle("Task List", displayMode: .inline)
        .toolbar {
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
}

// MARK: - View Builders
extension TaskManagerView {
    @ViewBuilder func TaskListRow(task: TaskList) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(task.name)
                    .font(.headline)
                if let repetition = task.repeated {
                    Text(TaskHelper.convertRepetition(repetition))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }.padding(8)
    }
}

struct TaskManagerView_Previews: PreviewProvider {
    static var previews: some View {
        TaskManagerView()
    }
}
