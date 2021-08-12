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
        let id = "5Hs6LXW7wMgihcrCaZ3RjnOFAiz1"
            employee = "companies/\(id)/employees"
            task = "companies/\(id)/tasks"
            taskList = "companies/\(id)/taskList"
//        }
    }
}
