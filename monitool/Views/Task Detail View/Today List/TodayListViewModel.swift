//
//  TodayListViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 07/08/21.
//

import Foundation

class TodayListViewModel: TaskDetailViewModel {
	@Published var notesText = ""
	@Published var picSelection = 0
	@Published var isEmployeePickerPresenting = false
	private var taskRepository = TaskRepository.shared

	func submitTask(pic: Employee, notes: String? = nil) {
		taskRepository.updatePIC(id: task.id, employee: pic)
		
		if let notes = notes, notes != "" {
			taskRepository.updateNotes(id: task.id, notes: notes)
		}

		taskRepository.updateStatus(id: task.id, status: TaskStatus.waitingEmployeeReview.rawValue)
	}
}
