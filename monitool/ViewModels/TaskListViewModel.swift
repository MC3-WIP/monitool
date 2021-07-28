//
//  TaskViewModel.swift
//  monitool
//
//  Created by Devin Winardi on 28/07/21.
//

import Combine

final class TaskListViewModel: ObservableObject {
    @Published var taskRepository = TaskRepository()
    @Published var tasks: [Task] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(){
        taskRepository.$tasks
            .assign(to: \.tasks, on: self)
            .store(in: &cancellables)
    }
    
    func add(_ task: Task){
        taskRepository.add(task)
    }
}
