//
//  Employee.swift
//  monitool
//
//  Created by Christianto Budisaputra on 27/07/21.
//

// MARK: - Properties
struct Employee: Codable {
	var name: String
	var pin: String

	init(name: String) {
		self.name = name
		pin = Helper.generatePIN()
	}
}

// MARK: - Methods
extension Employee {
	func review(task: _Task) -> Self {
		task.reviewer += 1
		return self
	}

	func submit(task: _Task, notes: String = "") -> Self {
		task.status = .waitingPeerReview
		task.notes = notes
		return self
	}
}

enum TaskStatus {
	case ongoing,
		 waitingPeerReview
}

class _Task {
	var status: TaskStatus = .ongoing
	var reviewer = 0
	var notes = ""
}
