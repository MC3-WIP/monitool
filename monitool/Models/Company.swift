//
//  Company.swift
//  monitool
//
//  Created by Mac-albert on 28/07/21.
//

import Foundation
import FirebaseFirestoreSwift

class Company: Codable{
	@DocumentID var id: String!

	var name: String
	var minReview: Int
	var ownerPin: String

	init(name: String, minReview: Int, ownerPin: String) {
		self.name = name
		self.minReview = minReview
		self.ownerPin = ownerPin
	}
}
