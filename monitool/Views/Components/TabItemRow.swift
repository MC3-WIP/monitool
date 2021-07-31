//
//  TabItemRow.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct TabItemRow: View {

	let title: String
	let icon: String

	init(title: String, icon: String) {
		self.title = title
		self.icon = icon
	}

    var body: some View {
		HStack {
			Image(systemName: icon)
			Text(title)
		}
		.padding()
    }
}

struct TabItemRow_Previews: PreviewProvider {
    static var previews: some View {
        TabItemRow(title: "Task List", icon: "list.number")
    }
}
