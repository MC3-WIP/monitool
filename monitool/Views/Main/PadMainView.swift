//
//  PadMenu.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct PadMainView: View {
	var body: some View {
		NavigationView {
			SidebarView()
			TaskListView()
		}
	}
}

struct PadMenu_Previews: PreviewProvider {
	static var previews: some View {
		PadMainView()
	}
}
