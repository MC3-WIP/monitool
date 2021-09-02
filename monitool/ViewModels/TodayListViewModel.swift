//
//  TodayListViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 07/08/21.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class TodayListViewModel: TaskDetailViewModel {
    // Modals state
    @Published var isImagePickerShowing = false

    override init(task: Task) {
        super.init(task: task)
    }

	func submitTask(pic: Employee, notes: String? = nil) {
		taskRepository.updatePIC(taskID: task.id, employee: pic)

		if let notes = notes, notes != "" {
			taskRepository.updateNotes(taskID: task.id, notes: notes)
		}

		taskRepository.updateStatus(taskID: task.id, status: TaskStatus.waitingEmployeeReview.rawValue)
        taskRepository.updateLogTask(taskID: task.id, titleLog: "Submited by \(pic.name)", timeStamp: Date())
	}
}
