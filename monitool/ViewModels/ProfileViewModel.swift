//
//  ProfileViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 05/08/21.
//

import FirebaseFirestore
import Foundation

class ProfileViewModel: ObservableObject {
	// Company Data
	@Published var company: Company
	@Published var employees = [Employee]()

	// UI State
	@Published var isPinHidden = true
	@Published var isPinPresenting = false
	@Published var isAddEmployeePresenting = false

	init(company: Company) {
		self.company = company
	}

	func delete(_ offsets: IndexSet) {
		offsets.forEach { index in
			employees.remove(at: index)
		}
	}

	var reviewerString: String {
		"\(company.minReview) Reviewer\(company.minReview > 1 ? "s" : "")"
	}

	func incrementReviewer() {
		company.minReview += 1
		if company.minReview > employees.count { company.minReview = employees.count }
	}

	func decrementReviewer() {
		company.minReview -= 1
		if company.minReview < 0 { company.minReview = 0 }
	}
}
