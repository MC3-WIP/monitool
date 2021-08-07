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

	@ViewBuilder
	func route(_ filter: TaskStatus?, task: Task) -> some View {
		if let filter = filter {
			switch filter {
			case .ongoing:
				TodayListView(task: task)
			case .waitingEmployeeReview:
				EmployeeReviewView()
			case .waitingOwnerReview:
				OwnerReviewView()
			case .revise:
				ReviseView()
			default:
				EmptyView()
			}
		} else {
			TaskListDetailView()
		}
	}
}
