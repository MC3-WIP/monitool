//
//  TaskDetailViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 07/08/21.
//

import Foundation

class TaskDetailViewModel: ObservableObject {
	@Published var task: Task
	var pic: Employee?

	init(task: Task) {
		self.task = task
		getPIC()
	}

	func getPIC() {
		task.pic?.getDocument(completion: { doc, err in
			if let err = err {
				fatalError("Unresolved error: \(err.localizedDescription)")
			}

			if let doc = doc {
				do {
					self.pic = try doc.data(as: Employee.self)
				} catch {
					print("Unresolved error: \(error.localizedDescription)")
				}
			}
		})
	}
}
