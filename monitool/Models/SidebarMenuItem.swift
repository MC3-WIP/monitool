//
//  SidebarMenuItem.swift
//  monitool
//
//  Created by Christianto Budisaputra on 17/08/21.
//

import SwiftUI

enum SidebarMenuItem: CaseIterable {
	case todayList,
		 peerReview,
		 ownerReview,
		 revise,
		 taskList,
		 history,
		 profile

	var title: String {
		switch self {
		case .todayList:
			return "Today List"
		case .peerReview:
			return RoleService.shared.isOwner ? "Waiting Employee Review" : "Waiting Peer Review"
		case .ownerReview:
			return "Waiting Owner Review"
		case .revise:
			return "Revise"
		case .taskList:
			return "Task List"
		case .history:
			return "History"
		case .profile:
			return "Profile"
		}
	}

	var icon: String {
		switch self {
		case .todayList:
			return AppIcon.todayList
		case .peerReview:
			return AppIcon.employeeReview
		case .ownerReview:
			return AppIcon.ownerReview
		case .revise:
			return AppIcon.revise
		case .taskList:
			return AppIcon.taskList
		case .history:
			return AppIcon.history
		case .profile:
			return AppIcon.profile
		}
	}

	var view: AnyView {
		switch self {
		case .todayList:
			return AnyView(TaskListView(filter: .constant(.todayList)))
		case .peerReview:
			return AnyView(TaskListView(filter: .constant(.waitingEmployeeReview)))
		case .ownerReview:
			return AnyView(TaskListView(filter: .constant(.waitingOwnerReview)))
		case .revise:
			return AnyView(TaskListView(filter: .constant(.revise)))
		case .taskList:
			return AnyView(TaskListView(filter: .constant(nil)))
		case .history:
			return AnyView(HistoryView())
		case .profile:
			return AnyView(ProfileView())
		}
	}
}
