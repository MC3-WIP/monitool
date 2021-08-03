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

	init() {
//		if let id = Auth.auth().currentUser?.uid {
        let id = "w7zd8Hi13yaQEJdVea79105p5aU2"
			employee = "companies/\(id)/employees"
			task = "companies/\(id)/tasks"
//        }
	}
}
