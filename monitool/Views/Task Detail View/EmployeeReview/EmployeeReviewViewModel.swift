//
//  EmployeeReviewViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 09/08/21.
//

import Foundation
import SwiftUI

class EmployeeReviewViewModel: TaskDetailViewModel {
	private let employeeRepository: EmployeeRepository = .shared
	private let taskRepository: TaskRepository = .shared
	private var companyRepository: CompanyRepository = .shared

	@Published var company: Company?

	override init(task: Task) {
		super.init(task: task)

		if let ref = companyRepository.companyRef {
			ref.getDocument(completion: { doc, err in
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
		} else {
			// Resolve kalo gaada
		}
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

	private func validateApproval(pin: String) -> TaskErrorType? {
		if findEmployeeBy(pin: pin) == nil { return .pinNotFound }
		if let pic = pic, pic.pin == pin { return .pinEqualsPIC }

		return nil
	}

	//	func approveTask(pin: String, isAlert: Binding<Bool>, errorType: Binding<TaskErrorType>) {
	func approveTask(pin: String) {
		if let error = validateApproval(pin: pin) {
			//			isAlert.wrappedValue = true
			//			errorType.wrappedValue = error
			print("Validation Error:", error.rawValue)
		} else if let employee = findEmployeeBy(pin: pin) {
			print("Employee:", employee.name)
			taskRepository.appendReviewer(taskID: task.id, employee: employee) { err in
				if let err = err {
					print(err.localizedDescription)
				} else {
					DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
						print("\(employee.name) Appended Successfully!")

						print("\(self.task.reviewer?.count ?? -1) || \(self.company?.name ?? "Company is nil")!")
						if let reviewer = self.task.reviewer,
						   let company = self.company,
						   reviewer.count == company.minReview {
							self
								.taskRepository
								.updateStatus(
									taskID: self.task.id,
									status: TaskStatus.waitingOwnerReview.rawValue
								) { err in
									if let err = err {
										print(err.localizedDescription)
									} else {
										print("Done!")
									}
								}
						}
					}
				}
			}
		}
	}
}

enum TaskErrorType: String {
	case pinNotFound = "PIN Not Found."
	case pinEqualsPIC = "PIC should not review his own task."
}
