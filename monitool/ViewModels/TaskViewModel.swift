//
//  TaskViewModel.swift
//  monitool
//
//  Created by Devin Winardi on 28/07/21.
//

import Combine
import SwiftUI

class TaskViewModel: ObservableObject {
	@ObservedObject private var repository = TaskRepository()
    @Published var tasks = [Task]()
    
    private var cancellables = Set<AnyCancellable>()

    init(){
        repository.$tasks
            .assign(to: \.tasks, on: self)
            .store(in: &cancellables)
    }

    func add(_ task: Task){
        repository.add(task)
    }

	func delete(_ offsets: IndexSet) {
		offsets.forEach { index in
			repository.delete(tasks[index])
		}
	}
}
