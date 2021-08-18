//
//  Strings.swift
//  monitool
//
//  Created by Christianto Budisaputra on 22/07/21.
//

import SwiftUI
// Usage Example
// Strings.TaskList.title

enum Strings {
	// MARK: Page
	/// Task List Page
	enum TaskList: LocalizedStringKey {
		case title = "tasklist.title"
	}

	// MARK: Task Status
	enum TaskStatus: LocalizedStringKey {
		case ongoing = "taskstatus.ongoing",
			 waitingPeerReview = "taskstatus.peer_review",
			 waitingOwnerReview = "taskstatus.owner_review",
			 revised = "taskstatus.revise",
			 completed = "taskstatus.completed"
	}
}

// extension String {
//	var localized: String {
//		NSLocalizedString(self, comment: "")
//	}
// }
