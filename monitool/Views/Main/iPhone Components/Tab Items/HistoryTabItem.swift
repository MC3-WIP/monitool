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
				Image(systemName: "clock")
				Text("History")
			}
			.navigationTitle("History")
    }
}

struct HistoryTabItem_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTabItem()
    }
}
