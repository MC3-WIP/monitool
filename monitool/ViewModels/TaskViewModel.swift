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
    @ObservedObject private var taskListRepository: TaskListRepository = .shared
    @Published var tasks = [Task]()
    @Published var histories = [Task]()
    @Published var historiesPerDay = [[Task]]()

    private var cancellables = Set<AnyCancellable>()

    static let shared = TaskViewModel()

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

    func repeatTask(day: Int) {
        repository.repeatTask(day: day, taskListRepo: taskListRepository)
    }
}
