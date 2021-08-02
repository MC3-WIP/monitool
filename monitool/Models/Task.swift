//
//  Task.swift
//  monitool
//
//  Created by Devin Winardi on 27/07/21.
//

import Foundation
import FirebaseFirestoreSwift

class Task: Codable, Identifiable {
	@DocumentID var id: String!
	var name: String
	var status: TaskStatus
	var createdAt: Date
	var repeated: [Bool] = [false]
	var desc: String = ""
	var proof: Data?
	var notes: String?

	var pic: Employee?
	var reviewer: [Employee]?

	init(name: String, status: TaskStatus = .ongoing){
		self.name = name
		self.status = status
		self.createdAt = Date()
	}
}

enum TaskStatus: Int, Codable, CaseIterable {
	case ongoing = 0
	case waitingEmployeeReview = 1
	case waitingOwnerReview = 2
	case revise = 3
	case completed = 4

	var title: String {
		switch self {
		case .ongoing:
			return "Today List"
		case .waitingEmployeeReview:
			return "Waiting Employee Review"
		case .waitingOwnerReview:
			return "Waiting Owner Review"
		case .revise:
			return "Revise"
		case .completed:
			return "Completed"
		}
	}

	var icon: String {
		switch self {
		case .ongoing:
			return "largecircle.fill.circle"
		case .waitingEmployeeReview:
			return "person.2"
		case .waitingOwnerReview:
			return "person.crop.circle.badge.checkmark"
		case .revise:
			return "repeat"
		case .completed:
			return "checkmark.circle"
		}
	}

	var notification: TaskNotification {
		switch self {
		case .ongoing:
			return TaskNotification(isPriority: false, count: 12)
		case .waitingEmployeeReview:
			return TaskNotification(isPriority: false, count: 4)
		case .waitingOwnerReview:
			return TaskNotification(isPriority: false, count: 3)
		case .revise:
			return TaskNotification(isPriority: true, count: 2)
		case .completed:
			return TaskNotification(isPriority: false, count: 3)
		}
	}
}
