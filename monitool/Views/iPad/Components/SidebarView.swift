//
//  Sidebar.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct SidebarView: View {
	@EnvironmentObject var padLayout: PadLayoutViewModel
	@StateObject var viewModel = SidebarViewModel()
	@ObservedObject var role: RoleService = .shared

	var body: some View {
		ScrollView {
			LazyVStack(alignment: .leading) {
				filteredTaskList()
				Divider()
				menuItemView(type: .history)
				Divider()
				if role.isOwner {
					menuItemView(type: .taskList)
				}
				menuItemView(type: .profile)
			}
			.padding()
		}
		.navigationTitle("Monitool")
	}
}

// MARK: - View Builders
extension SidebarView {
	@ViewBuilder func filteredTaskList() -> some View {
		Group {
			menuItemView(type: .todayList)
			menuItemView(type: .peerReview)
			menuItemView(type: .ownerReview)
			menuItemView(type: .revise)
		}
	}

	@ViewBuilder func menuItemView(type: SidebarViewModel.MenuItem) -> some View {
		HStack {
			Image(systemName: type.icon)
				.foregroundColor(viewModel.selectedMenuItem == type ? AppColor.primaryForeground : AppColor.accent)
			Text(type.title)
				.foregroundColor(viewModel.selectedMenuItem == type ? AppColor.primaryForeground : AppColor.primaryBackground)
			Spacer()
//			if let notification = notification, notification.count > 0 {
//				Text("\(notification.count)")
//					.foregroundColor(notification.isPriority || isActive ? AppColor.primaryForeground : AppColor.secondary)
//					.frame(width: 24, height: 24, alignment: .center)
//					.background(notification.isPriority ? Color.red : Color.clear)
//					.clipShape(Circle())
//			}
		}
		.padding(12)
		.background(viewModel.selectedMenuItem == type ? AppColor.accent : Color.clear)
		.cornerRadius(12)
		.contentShape(Rectangle())
		.onTapGesture {
			viewModel.selectedMenuItem = type
			padLayout.currentDetailViewType = type
			switch type {
			case .todayList:
				padLayout.currentTaskFilter = .todayList
			case .peerReview:
				padLayout.currentTaskFilter = .waitingEmployeeReview
			case .ownerReview:
				padLayout.currentTaskFilter = .waitingOwnerReview
			case .revise:
				padLayout.currentTaskFilter = .revise
			case .taskList:
				padLayout.currentTaskFilter = nil
			default: break
			}
		}
	}
}

struct Sidebar_Previews: PreviewProvider {
	static var previews: some View {
		SidebarView()
	}
}
