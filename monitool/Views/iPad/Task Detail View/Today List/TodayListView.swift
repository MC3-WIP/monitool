//
//  TodayListView.swift
//  monitool
//
//  Created by Mac-albert on 07/08/21.
//

import SwiftUI

struct TodayListView: View {
    @StateObject var todayListViewModel: TodayListViewModel
    @ObservedObject var role: RoleService = .shared
    @ObservedObject var employeeRepository: EmployeeRepository = .shared
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    init(task: Task) {
        _todayListViewModel = StateObject(wrappedValue: TodayListViewModel(task: task))
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack(alignment: .top, spacing: 24) {
                    LeftColumn()
                    RightColumn()
                }
                .padding(.top)
            }
        }
        .padding([.leading, .trailing], 24)
        .navigationTitle("Today List")
    }
}

// MARK: - Previews

struct TodayListView_Previews: PreviewProvider {
    static var previews: some View {
        TodayListView(task: Task(name: "Hehe", repeated: []))
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
    }
}
