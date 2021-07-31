//
//  HistoryView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct HistoryTabItem: View {
    var body: some View {
        Text("History View!")
			.tabItem {
				Label(
					title: { Text("History") },
					icon: { Image(systemName: "clock") }
				)
			}
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTabItem()
    }
}
