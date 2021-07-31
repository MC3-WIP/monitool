//
//  Sidebar.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct SidebarView: View {

	var body: some View {
		List {
			ForEach(1..<5) { index in
				TabItemRow(title: "Menu \(index)", icon: "list.number")
			}
		}
		.listStyle(InsetListStyle())
		.navigationTitle("Monitool")
	}
}

struct Sidebar_Previews: PreviewProvider {
	static var previews: some View {
		SidebarView()
	}
}
