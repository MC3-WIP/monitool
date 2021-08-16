//
//  PadMenu.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct PadLayout: View {
	var body: some View {
		NavigationView {
			ZStack {
				AppColor.secondary.edgesIgnoringSafeArea(.all)
				SidebarView()
			}
		}
		.styleNavigationBar()
		.accentColor(AppColor.accent)
	}
}

struct PadMenu_Previews: PreviewProvider {
	static var previews: some View {
		PadLayout()
	}
}
