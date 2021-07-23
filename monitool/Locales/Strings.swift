//
//  Strings.swift
//  monitool
//
//  Created by Christianto Budisaputra on 22/07/21.
//

import Foundation

// Usage Example
// Strings.TaskList.title

enum Strings {
	// MARK: Page
	/// Task List Page
    enum Onboarding {
        static let signIn = "onboarding.signIn".localized
    }
    
    enum CompanyProfileOnboarding {
        static let title = "CompanyProfileOnboarding.title".localized
        static let placeholder = "CompanyProfileOnboarding.placeholder".localized
        static let companyNameTitle = "CompanyProfileOnboarding.companyNameTitle".localized
        static let saveBtn = "CompanyProfileOnboarding.saveBtn".localized
        static let employeeTitle = "CompanyProfileOnboarding.employeeTitle".localized
    }
    
    enum AddTask {
        static let title = "AddTask.title".localized
        static let descriptionTitle = "AddTask.descriptionTitle".localized
        static let repeatTitle = "AddTask.repeatTitle".localized
        static let titleTitle = "AddTask.titleTitle".localized
        static let placeholder = "AddTask.placeholder".localized
    }
    
	enum ToDoList {
        static let title = "ToDoList.title".localized
        static let statusTask = "ToDoList.statusTask".localized
	}
    
    enum TaskDetail{
        static let title = "TaskDetail.title".localized
        static let approveBtn = "TaskDetail.approveBtn".localized
        static let reviseBtn = "TaskDetail.reviseBtn".localized
        static let takePhotoBtn = "TaskDetail.takePhotoBtn".localized
    }
    
    enum PopOverRepeatAddTask {
        static let repeatTitle = "PopOverRepeatAddTask.repeatTitle".localized
        static let sunday = "PopOverRepeatAddTask.sunday".localized
        static let monday = "PopOverRepeatAddTask.monday".localized
        static let tuesday = "PopOverRepeatAddTask.tuesday".localized
        static let wednesday = "PopOverRepeatAddTask.wednesday".localized
        static let thursday = "PopOverRepeatAddTask.thursday".localized
        static let friday = "PopOverRepeatAddTask.friday".localized
        static let saturday = "PopOverRepeatAddTask.saturday".localized
    }
    
    enum PinModal {
        static let title = "PinModal.title".localized
    }
    
    enum Profile {
        static let switchToRoleBtn = "Profile.switchToRoleBtn".localized
    }
}


extension String {
	var localized: String {
		NSLocalizedString(self, comment: "")
	}
}
