//
//  TaskViewModel.swift
//  monitool
//
//  Created by Devin Winardi on 28/07/21.
//

import Combine
import SwiftUI

class TaskViewModel: ObservableObject {
    @ObservedObject private var repository: TaskRepository = .shared
    @Published var tasks = [Task]()
    @Published var histories = [Task]()
    @Published var historiesPerDay = [[Task]]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        repository.$tasks
            .assign(to: \.tasks, on: self)
            .store(in: &cancellables)
        repository.$histories
            .assign(to: \.histories, on: self)
            .store(in: &cancellables)
        separateHistories()
    }

    func separateHistories() {
        let dateHelper = DateHelper()
        for index in 0 ... 6 {
            let historyOfDay = histories.filter { history in
                dateHelper.getNumDays(first: history.createdAt, second: Date()) == index
            }
            historiesPerDay.append(historyOfDay)
        }
    }

    func add(_ task: Task, _ taskList: TaskList, photo: UIImage, id: String) {
        repository.submitTask(task: task, taskList: taskList, photo: photo, id: id)
    }

    func add(_ task: Task, _ taskList: TaskList, id: String) {
        repository.submitTask(task: task, taskList: taskList, id: id)
    }

    func delete(_ offsets: IndexSet) {
        offsets.forEach { index in
            repository.delete(tasks[index])
        }
    }

    func updateStatus(id: String, status: String) {
        repository.updateStatus(taskID: id, status: status)
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
