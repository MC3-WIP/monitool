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

	func submitTask(pic: Employee, notes: String? = nil) {
		taskRepository.updatePIC(taskID: task.id, employee: pic)

		if let notes = notes, notes != "" {
			taskRepository.updateNotes(taskID: task.id, notes: notes)
		}

		taskRepository.updateStatus(taskID: task.id, status: TaskStatus.waitingEmployeeReview.rawValue)
	}
}
