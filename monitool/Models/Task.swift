//
//  Task.swift
//  monitool
//
//  Created by Devin Winardi on 27/07/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class Task: Codable, Identifiable {
	@DocumentID var id: String!
	let name: String
	let desc: String?
	let createdAt: Date

	var status: TaskStatus
	var repeated: [Bool]?
	var proof: [String]?
	var notes: String?

	var pic: DocumentReference?
	var reviewer: [DocumentReference]?
    
    var isHistory: Bool
    
    var photoReference: [String]?

	init(
		name: String, 
		description: String? = nil,
        photoReference: [String]? = nil
	) {
		self.name = name
		desc = description
		createdAt = Date()
		status = .ongoing
        isHistory = false
        self.photoReference = photoReference
	}
}

enum TaskStatus: String, Codable, CaseIterable {
	case ongoing = "Ongoing"
	case waitingEmployeeReview = "Waiting Employee Review"
	case waitingOwnerReview = "Waiting Owner Review"
	case revise = "Revise"
	case completed = "Completed"

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
}
