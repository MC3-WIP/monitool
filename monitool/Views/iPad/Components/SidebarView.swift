//
//  Sidebar.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct SidebarView: View {
	@ObservedObject var role: RoleService = .shared

	init() {
		UITableView.appearance().backgroundColor = .clear
	}

	var body: some View {
		List {
			SidebarMenuItemModel(type: .todayList)
			SidebarMenuItemModel(type: .peerReview)
			SidebarMenuItemModel(type: .ownerReview)
			SidebarMenuItemModel(type: .revise)
			if role.isOwner {
				SidebarMenuItemModel(type: .taskList)
			}
			SidebarMenuItemModel(type: .history)
			SidebarMenuItemModel(type: .profile)
		}
		.listStyle(SidebarListStyle())
		.navigationTitle("Monitool")
	}
}

struct Sidebar_Previews: PreviewProvider {
	static var previews: some View {
		SidebarView()
	}
}
