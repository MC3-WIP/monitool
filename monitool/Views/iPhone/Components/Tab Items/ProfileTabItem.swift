//
//  ProfileView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct ProfileTabItem: View {
	var body: some View {
		NavigationView {
			VStack {
			}
			.toolbar {
				EditButton()
			}
			.navigationBarTitle("Profile", displayMode: .inline)
		}
		.tabItem {
			Image(systemName: "person.crop.circle")
			Text("Profile")
		}
	}
}

struct ProfileTabItem_Previews: PreviewProvider {
	static var previews: some View {
		ProfileTabItem()
	}
}
