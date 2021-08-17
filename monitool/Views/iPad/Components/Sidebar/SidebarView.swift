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
			SidebarMenuItemView(type: .todayList)
			SidebarMenuItemView(type: .peerReview)
			SidebarMenuItemView(type: .ownerReview)
			SidebarMenuItemView(type: .revise)
			if role.isOwner {
				SidebarMenuItemView(type: .taskList)
			}
			SidebarMenuItemView(type: .history)
			SidebarMenuItemView(type: .profile)
		}
		.listStyle(SidebarListStyle())
		.navigationTitle("Monitool")
	}
}
