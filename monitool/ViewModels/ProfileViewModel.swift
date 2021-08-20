//
//  ProfileViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 05/08/21.
//

import FirebaseFirestore
import Foundation
import FirebaseAuth
import FirebaseStorage

class ProfileViewModel: ObservableObject {

	@Published var employees = [Employee]()
	@Published var company: Company

	// UI State
	@Published var isPinHidden = true
	@Published var isPinPresenting = false
	@Published var isAddEmployeePresenting = false

    @Published var pinInputted = ""
    @Published var showingAlert = false
    @Published var isPasscodeFieldDisabled = false
    @Published var isPinRight = false

	private let companyRepository: CompanyRepository = .shared

	init() {
		company = Company(name: "", minReview: 0, ownerPin: "", hasLoggedIn: true, profileImage: "")
		getCompany()
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

	func updateCompany(companyName: String, companyPIN: String, minReview: Int) {
        companyRepository.editCompanyName(name: companyName)
        companyRepository.editCompanyPIN(ownerPIN: companyPIN)
        companyRepository.editCompanyMinReview(minReview: minReview)
    }

	func getCompany() {
		if let ref = companyRepository.companyRef {
			ref.getDocument { doc, err in
				if let err = err { fatalError("Unresolved error: \(err)") }

				if let doc = doc, doc.exists {
					do {
						if let company = try doc.data(as: Company.self) {
							self.company = company
						}
					} catch {
						print(error.localizedDescription)
					}
				}
			}
		}
	}
}
