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
		if let id = Auth.auth().currentUser?.uid {
			employee = "companies/\(id)/employees"
			task = "companies/\(id)/tasks"
        }
	}
}
