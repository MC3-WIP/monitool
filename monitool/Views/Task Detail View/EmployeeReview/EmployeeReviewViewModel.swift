//
//  EmployeeReviewViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 09/08/21.
//

import Foundation

class EmployeeReviewViewModel: TaskDetailViewModel {
	private let employeeRepository: EmployeeRepository = .shared
	private let taskRepository: TaskRepository = .shared
	private var companyRepository: CompanyRepository = .shared

	private var company: Company?

	override init(task: Task) {
		super.init(task: task)

		companyRepository.companyRef?.getDocument(completion: { doc, err in
			if let err = err {
				fatalError("Unresolved error: \(err)")
			}

			if let doc = doc {
				do {
					self.company = try doc.data(as: Company.self)
				} catch {
					print("Unresolved error: \(error.localizedDescription)")
				}
			}
		})
	}

	private func findEmployeeBy(pin: String) -> Employee? {
		var match: Employee?

		employeeRepository.employees.forEach { employee in
			if pin == employee.pin {
				match = employee
			}
		}

		return match
	}

	private func validateApproval(pin: String) -> Bool {
		if findEmployeeBy(pin: pin) == nil { return false }
		if let pic = pic, pic.pin == pin { return false }

		return true
	}

	func approveTask(pin: String) {
		if validateApproval(pin: pin) {
			if let employee = findEmployeeBy(pin: pin) {
				taskRepository.appendReviewer(taskID: task.id, employee: employee)
			}

			if let reviewer = task.reviewer,
			   let company = company,
			   reviewer.count == company.minReview {
				taskRepository.updateStatus(taskID: task.id, status: TaskStatus.waitingOwnerReview.rawValue)
			}
		}
	}
}
