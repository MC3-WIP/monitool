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

	init() {
		UITableView.appearance().backgroundColor = .clear
	}

	var body: some View {
		List {
			ForEach(SidebarMenuItem.allCases, id: \.self) { menuItem in
				if role.isOwner, menuItem == SidebarMenuItem.taskList { EmptyView() }

				NavigationLink(destination: menuItem.view) {
					HStack {
						Image(systemName: menuItem.icon)
							.foregroundColor(AppColor.accent)
						Text(menuItem.title)
					}.padding(5)
				}
			}
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
