//
//  EmployeeRepository.swift
//  monitool
//
//  Created by Christianto Budisaputra on 28/07/21.
//

import FirebaseFirestore
import Combine

class EmployeeRepository: ObservableObject {
	@Published var employees = [Employee]()
	private let paths = RepositoriesPath()

	private let store = Firestore.firestore()
	private let employeeRepository: CollectionReference

    init() {
		employeeRepository = store.collection(paths.employee)
		get()
        print("employees")
        print(employees.count)
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
//        guard let storyId = story.storyId else { return }
//        guard let docId = story.id else { return}
//
//        store.collection(path).document(docId).delete { error in
//            if let error = error {
//                print("Unable to remove card: \(error.localizedDescription)")
//            }  else {
//                print("Successfully deleted  story text")
//            }
//        }
//        storage.reference().child("stories/\(storyId)/1").delete { error in
//            if let error = error {
//                print("Unable to delete story image: \(error.localizedDescription)")
//            } else {
//                print("Successfully deleted  story image")
//            }
//        }
    }
}
