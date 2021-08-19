//
//  HistoryView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import SwiftUI

struct HistoryTabItem: View {
    private var device = UIDevice.current.userInterfaceIdiom
    @ObservedObject private var taskViewModel = TaskViewModel()
    private let dateHelper = DateHelper()

    init() {
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some View {
        List {
            ForEach(0..<6) { index in
                if taskViewModel.historiesPerDay[index].count == 0 {
                    EmptyView()
                } else {
                    HistoriesSection(histories: taskViewModel.historiesPerDay[index])
                        .padding(.vertical, 5)
                }
            }
        }
        .navigationBarTitle("History", displayMode: .inline)
        .listStyle(InsetGroupedListStyle())
        .background(Color.white)
    }
}
