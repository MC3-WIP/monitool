//
//  TaskListViewModel.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 04/08/21.
//

import Combine
import SwiftUI

final class TaskListViewModel: ObservableObject {
    @ObservedObject private var repository: TaskListRepository = .shared
    @Published var taskLists = [TaskList]()

    private var cancellables = Set<AnyCancellable>()

    static let shared = TaskListViewModel()

    private init() {
        repository.$taskLists
            .assign(to: \.taskLists, on: self)
            .store(in: &cancellables)
    }

    func add(_ taskList: TaskList) {
        repository.add(taskList)
    }

    func delete(_ offsets: IndexSet) {
        offsets.forEach { index in
            repository.delete(taskLists[index])
        }
    }

    func update(id: String, name: String, desc: String, repeated: [Bool]) {
        repository.updateTask(
            taskID: id,
            name: name,
            desc: desc,
            repeated: repeated
        )
    }

    func updatePhotoReference(image: UIImage, taskID: String, completion: ((Error?) -> Void)? = nil) {
        StorageService
            .shared
            .upload(image: image, path: "taskPhotoReference/\(taskID)") { metadata, _ in
                if let metadata = metadata,
                   let path = metadata.path
                {
                    self.repository.updatePhotoReference(
                        taskID: taskID,
                        photoRef: path,
                        completion: completion
                    )
                }
            }
    }
}
