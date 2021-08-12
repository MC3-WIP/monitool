//
//  SidebarViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import Foundation

class SidebarViewModel: ObservableObject {
	@Published var taskFilterByStatus: TaskStatus?
	@Published var selectedMenuItem: MenuItem

	init(
		taskFilter: TaskStatus = .todayList,
		selectedMenu: MenuItem = .todayList
	) {
		taskFilterByStatus = taskFilter
		selectedMenuItem = selectedMenu
	}
}

extension SidebarViewModel {
	enum MenuItem {
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
	}
}
