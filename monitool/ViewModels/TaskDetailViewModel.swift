//
//  TaskDetailViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 07/08/21.
//

import FirebaseFirestore
import Foundation

class TaskDetailViewModel: ObservableObject, RightColumnViewModel {
	@Published var notesTextField       = ""
	@Published var commentTextField     = ""

	@Published var imageToBeAdded: UIImage?
	@Published var proofOfWork: [String]?

	@Published var logs = [ActivityLog]()

	@Published var picSelection = 0

	@Published var isEmployeePickerPresenting = false

	@Published var task: Task

	var comment: String {
		task.comment ?? "-"
	}
	var notes: String {
		task.notes ?? "-"
	}
	var employees: [Employee] {
		EmployeeRepository.shared.employees
	}

	var photoReference: String? {
		task.photoReference
	}

	var title: String {
		task.name
	}

	var desc: String {
		task.desc ?? ""
	}

    let taskRepository: TaskRepository = .shared

    var company: Company?
    private let companyRepository: CompanyRepository = .shared

    @Published var pic: Employee?

    var reviewer = [Employee]() {
        didSet {
            if let company = company, reviewer.count == company.minReview {
                var approvalRatio: Float = 0

                if let approvingReviewer = task.approvingReviewer {
                    approvalRatio = Float(approvingReviewer.count) / Float(reviewer.count)
                }

                if approvalRatio >= 0.5 {
                    taskRepository.updateStatus(
                        taskID: task.id,
                        status: TaskStatus.waitingOwnerReview.rawValue
                    )
                } else {
                    taskRepository.updateStatus(
                        taskID: task.id,
                        status: TaskStatus.todayList.rawValue
                    ) { err in
                        if let err = err {
                            print("Error downgrading status: \(err.localizedDescription)")
                            return
                        }
                        self.taskRepository.dropDisapprovingReviewer(taskID: self.task.id)
                    }
                }
            }
        }
    }

    init(task: Task) {
        self.task = task
        getCompany()
        getPIC()
        getReviewer(task: task)
    }

    func getCompany() {
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
        }
    }

    func getPIC() {
        task.pic?.getDocument { [self] doc, err in
            getEmployee(doc, err) { employee in
                pic = employee
            }
        }
    }

    func getReviewer(task: Task) {
        self.task = task
        task.approvingReviewer?.forEach(mapReviewer)
        task.disapprovingReviewer?.forEach(mapReviewer)
    }

    private func mapReviewer(_ ref: DocumentReference) {
        ref.getDocument { [self] doc, err in
            getEmployee(doc, err) { employee in
                if let employee = employee {
                    reviewer.append(employee)
                }
            }
        }
    }

    private func getEmployee(_ doc: DocumentSnapshot?, _ err: Error?, completion: ((Employee?) -> Void)? = nil) {
        if let err = err {
            fatalError("Unresolved error: \(err.localizedDescription)")
        }

        if let doc = doc {
            do {
                let data = try doc.data(as: Employee.self)
                completion?(data)
            } catch {
                print("Unresolved error: \(error.localizedDescription)")
            }
        }
    }
}
