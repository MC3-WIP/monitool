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
        _selectedTab = State(wrappedValue: selectedTab)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            todoList
            TaskListTabItem()
                .tag(PhoneTabItem.taskList)
            ProfileTabItem()
                .tag(PhoneTabItem.profile)
        }.accentColor(AppColor.accent)
    }

    var todoList: some View {
        TodoListTabItem()
            .tabItem {
                Image(systemName: "list.bullet.rectangle")
                Text("To-Do List")
            }
            .tag(PhoneTabItem.todoList)
    }
}

struct PhoneMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
