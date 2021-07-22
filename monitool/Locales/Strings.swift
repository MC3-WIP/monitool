//
//  Strings.swift
//  monitool
//
//  Created by Christianto Budisaputra on 22/07/21.
//

import Foundation

// Usage Example
// Strings.TaskList.title

enum Strings {
	// MARK: Page
	/// Task List Page
	enum TaskList {
		static let title = "tasklist.title".localized
	}
}

extension String {
	var localized: String {
		NSLocalizedString(self, comment: "")
	}
}
