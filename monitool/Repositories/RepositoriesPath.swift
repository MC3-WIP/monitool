//
//  Repositories.swift
//  monitool
//
//  Created by Christianto Budisaputra on 29/07/21.
//

import FirebaseAuth

struct RepositoriesPath {
	var company = "companies"
	var employee = ""
	var task = ""
    var taskList = ""

	init() {
//		if let id = Auth.auth().currentUser?.uid {
			let id = "X5FvjKU0PnhJRV953lGDzt7OVHF3"
            employee = "companies/\(id)/employees"
            task = "companies/\(id)/tasks"
            taskList = "companies/\(id)/taskList"
//        }
    }
}
