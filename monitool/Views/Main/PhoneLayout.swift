//
//  PhoneMenu.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct PhoneLayout: View {
	enum PhoneTabItem {
		case todoList, taskList, profile
	}

	@State var selectedTab: PhoneTabItem

	init(selectedTab: PhoneTabItem = .todoList) {
		self.selectedTab = selectedTab
	}

	var body: some View {
		TabView(selection: $selectedTab) {
			TodoListTabItem()
				.tag(PhoneTabItem.todoList)
			TaskListTabItem()
				.tag(PhoneTabItem.taskList)
			ProfileTabItem()
				.tag(PhoneTabItem.profile)
		}
		.accentColor(AppColor.accent)
	}
}

struct PhoneMenu_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
