//
//  EmployeeRepository.swift
//  monitool
//
//  Created by Christianto Budisaputra on 28/07/21.
//

import FirebaseFirestore
import Combine

final class EmployeeRepository: ObservableObject {
	@Published var employees = [Employee]()
	private let paths = RepositoriesPath()

	private let store = Firestore.firestore()
	private let employeeRepository: CollectionReference

	static let shared = EmployeeRepository()

    private init() {
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
    
    func add(_ employee: Employee){
        do {
            _ = try store.collection(paths.employee).addDocument(from: employee)
        } catch{
            fatalError("Fail adding new employee")
        }
    }
    
    func delete(_ employee: Employee) {
        store.collection(paths.employee).document(employee.id).delete()
    }
}
