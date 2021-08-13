//
//  Employee.swift
//  monitool
//
//  Created by Christianto Budisaputra on 27/07/21.
//

// MARK: - Properties

import FirebaseFirestoreSwift
import Foundation

class Employee: Codable, Identifiable {
    @DocumentID var id: String!
	var name: String
	var pin: String

    init(name: String, pin: String? = nil) {
		self.name = name
		self.pin = pin ?? Helper.generatePIN()
	}
}
