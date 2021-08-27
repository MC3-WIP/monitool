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

	var picName: String {
		pic?.name ?? "-"
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

	private func validateApproval(pin: String) -> Result<Employee, TaskError> {
		if let pic = pic, pic.pin == pin { return .failure(.pinEqualsPIC) }

		if reviewer.map({ $0.pin }).contains(pin) {
			return .failure(.sameReviewerFound)
		}

		if let employee = findEmployeeBy(pin: pin) {
			return .success(employee)
		} else {
			return .failure(.pinNotFound)
		}
	}

	func handleReviewCompletion(_ err: Error?, approving _: Bool = true) {
		if let err = err {
			print("Error appending new reviewer", err.localizedDescription)
			return
		}

		taskRepository.get(id: task.id) { [self] task in
			if let task = task {
				getReviewer(task: task)
			}
		}
	}

	func approveTask(pin: String, isPinTrue: Binding<Bool?>, presentation: Binding<PresentationMode>, showPin: Binding<Bool>, pinInputted: Binding<String>, isPasscodeFieldDisabled: Binding<Bool>) {
		switch validateApproval(pin: pin) {
		case let .success(employee):
			showPin.wrappedValue = false
			presentation.wrappedValue.dismiss()
			taskRepository.appendReviewer(
				taskID: task.id,
				employee: employee
			) { self.handleReviewCompletion($0) }
		case let .failure(error):
			if isPinTrue.wrappedValue != nil {
				isPinTrue.wrappedValue = false
			}
			pinInputted.wrappedValue = ""
			isPasscodeFieldDisabled.wrappedValue = false
			print("Validation Error:", error.localizedDescription)
		}
	}

	func disapproveTask(pin: String, isPinTrue: Binding<Bool?>, presentation: Binding<PresentationMode>, showPin: Binding<Bool>, pinInputted: Binding<String>, isPasscodeFieldDisabled: Binding<Bool>) {
		switch validateApproval(pin: pin) {
		case let .success(employee):
			showPin.wrappedValue = false
			presentation.wrappedValue.dismiss()
			taskRepository.appendReviewer(
				approving: false,
				taskID: task.id,
				employee: employee
			) { self.handleReviewCompletion($0, approving: false) }
		case let .failure(error):
			if isPinTrue.wrappedValue != nil {
				isPinTrue.wrappedValue = false
			}
			pinInputted.wrappedValue = ""
			isPasscodeFieldDisabled.wrappedValue = false
			print("Validation Error:", error.localizedDescription)
		}
	}
}

enum TaskError: Error {
	case pinNotFound, pinEqualsPIC, sameReviewerFound

	var localizedDescription: String {
		switch self {
		case .pinNotFound: return "PIN Not Found."
		case .pinEqualsPIC: return "PIC should not review his own task."
		case .sameReviewerFound: return "No duplicate reviewer shall exists."
		}
	}
}
