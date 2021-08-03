//
//  SidebarViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import Foundation

class SidebarViewModel: ObservableObject {
	@Published var taskFilterByStatus: TaskStatus?
	@Published var role: RoleService
	@Published var selectedMenuItem: MenuItem

	init(
		taskFilter: TaskStatus = .ongoing,
		selectedMenu: MenuItem = .todayList
	) {
		taskFilterByStatus = taskFilter
		role = .shared
		selectedMenuItem = selectedMenu
	}
}

extension SidebarViewModel {
	enum MenuItem {
		case todayList,
			 peerReview,
			 ownerReview,
			 revise,
			 taskManager,
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
			case .taskManager:
				return "Task Manager"
			case .history:
				return "History"
			case .profile:
				return "Profile"
			}
		}

		var icon: String {
			switch self {
			case .todayList:
				return Icon.todayList
			case .peerReview:
				return Icon.employeeReview
			case .ownerReview:
				return Icon.ownerReview
			case .revise:
				return Icon.revise
			case .taskManager:
				return Icon.taskManager
			case .history:
				return Icon.history
			case .profile:
				return Icon.profile
			}
		}
	}
}
