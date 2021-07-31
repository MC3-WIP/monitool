//
//  ProfileView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct ProfileTabItem: View {
	var body: some View {
		Text("Profile View!")
			.tabItem {
				Label(
					title: { Text("Profile") },
					icon: { Image(systemName: "person.crop.circle") }
				)
			}
	}
}

struct ProfileView_Previews: PreviewProvider {
	static var previews: some View {
		ProfileTabItem()
	}
}
