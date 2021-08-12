//
//  HistoryView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct HistoryTabItem: View {
    var body: some View {
        NavigationView {
            HistoryViewIphone()
            .navigationTitle("History")
        }
        .tabItem {
            Image(systemName: "clock")
            Text("History")
        }
    }
}

struct HistoryTabItem_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTabItem()
    }
}
