//
//  Company.swift
//  monitool
//
//  Created by Mac-albert on 28/07/21.
//

import FirebaseFirestore
import Combine
import FirebaseAuth

final class CompanyRepository: ObservableObject {
	private let paths = RepositoriesPath()
	private let store = Firestore.firestore()
	var companyRef: DocumentReference?

	static let shared = CompanyRepository()

	private init() {
		if let user = Auth.auth().currentUser {
			companyRef = store.collection(paths.company).document(user.uid)
		}
	}

	func add(_ company: Company) {
		companyRef?.setData([
			"name": company.name,
			"minReview": company.minReview,
			"profileImage": "profile",
			"ownerPin": company.ownerPin
		])
	}

	func addImage(imageURL: String) {
		companyRef?.updateData(["profileImage": imageURL])
	}
}
