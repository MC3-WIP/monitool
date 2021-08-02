//
//  PhoneMenu.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct PhoneLayout: View {
	var body: some View {
		TabView {
			TaskListTabItem()
			HistoryTabItem()
			ProfileTabItem()
		}
	}
}

struct PhoneMenu_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
