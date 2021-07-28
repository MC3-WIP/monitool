//
//  Employee.swift
//  monitool
//
//  Created by Christianto Budisaputra on 27/07/21.
//

// MARK: - Properties
struct Employee: Codable {
	var name: String
	var pin: String

	init(name: String) {
		self.name = name
		pin = Helper.generatePIN()
	}
}
