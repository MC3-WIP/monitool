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
	var repeated: [Bool]
	var proof: [String]?
	var notes: String?

	var pic: DocumentReference?
	var reviewer: [DocumentReference]?
    
    var isHistory: Bool
    
    var photoReference: [String]?

	init(
		name: String, 
		description: String? = nil,
        photoReference: [String]? = nil,
        repeated: [Bool]
	) {
		self.name = name
		desc = description
		createdAt = Date()
		status = .ongoing
        isHistory = false
        self.photoReference = photoReference
        self.repeated = repeated
	}
}

enum TaskStatus: String, Codable, CaseIterable {
	case ongoing = "Today List"
	case waitingEmployeeReview = "Waiting Employee Review"
	case waitingOwnerReview = "Waiting Owner Review"
	case revise = "Revise"
	case completed = "Completed"

	var title: String {
		switch self {
		case .ongoing:
			return "Today List"
		case .waitingEmployeeReview:
			return RoleService.shared.isOwner ? "Waiting Employee Review" : "Waiting Peer Review"
		case .waitingOwnerReview:
			return "Waiting Owner Review"
		case .revise:
			return "Revise"
		case .completed:
			return "Completed"
		}
	}
}
