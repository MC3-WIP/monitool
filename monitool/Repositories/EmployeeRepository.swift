//
//  EmployeeRepository.swift
//  monitool
//
//  Created by Christianto Budisaputra on 28/07/21.
//

import FirebaseFirestore
import Combine

struct _Company {
	let id = "abc"
}

class EmployeeRepository: ObservableObject {
	private let company: _Company
	@Published var employees = [Employee]()
	private let paths = RepositoriesPath()

	private let store = Firestore.firestore()
	private let employeeRepository: CollectionReference

	init(company: _Company) {
		self.company = company
		employeeRepository = store.collection(paths.employee)
		get()
	}

	func get() {
		employeeRepository.addSnapshotListener { [self] querySnapshot, error in
			if let error = error {
				fatalError("Unresolved error \(error.localizedDescription)")
			}

			employees = querySnapshot?
				.documents
				.compactMap { try? $0.data(as: Employee.self) } ?? []
		}
	}
}
