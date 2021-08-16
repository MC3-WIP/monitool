//
//  SidebarViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import SwiftUI

class SidebarViewModel: ObservableObject {
	@Published var taskFilterByStatus: TaskStatus?
	@Published var selectedMenuItem: SidebarMenuItem

	init(
		taskFilter: TaskStatus = .todayList,
		selectedMenu: SidebarMenuItem = .todayList
	) {
		taskFilterByStatus = taskFilter
		selectedMenuItem = selectedMenu
	}
}
