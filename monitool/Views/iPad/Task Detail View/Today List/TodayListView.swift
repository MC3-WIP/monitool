//
//  TodayListView.swift
//  monitool
//
//  Created by Mac-albert on 07/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct TodayListView: View {
	@Environment(\.presentationMode) var presentationMode

	@StateObject var todayListViewModel: TodayListViewModel

	@ObservedObject var role: RoleService = .shared
    @ObservedObject var employeeRepository: EmployeeRepository = .shared

    init(task: Task) {
        _todayListViewModel = StateObject(wrappedValue: TodayListViewModel(task: task))
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                HStack(alignment: .top, spacing: 24) {
					renderLeftColumn()

                    VStack(alignment: .leading, spacing: 24) {
                        ProofOfWork(task: todayListViewModel.task)

                        RightColumn<TodayListViewModel>(
                            components: role.isOwner ? [
                                .picText,
                                .notesText
                            ] : [
                                .picSelector,
                                .notesTextField
                            ],
                            viewModel: todayListViewModel
                        )

                        if !role.isOwner {
                            Button("Submit") {
                                todayListViewModel.submitTask(
                                    pic: employeeRepository.employees[todayListViewModel.picSelection],
                                    notes: todayListViewModel.notesTextField
                                )

                                presentationMode.wrappedValue.dismiss()
                            }.buttonStyle(PrimaryButtonStyle())
                        }
                    }
                }
            }
        }
        .padding([.top, .leading, .trailing], 24.0)
        .navigationTitle("Today List")
    }

    @ViewBuilder func renderLeftColumn() -> some View {
        VStack(alignment: .leading) {
            Text(todayListViewModel.task.name).font(.title.bold())

            if let image = todayListViewModel.task.photoReference {
                WebImage(url: URL(string: image))
                    .resizable()
                    .indicator { _, _ in
                        ProgressView()
                    }
					.scaledToFit()
            } else {
                Image("MonitoolEmptyReferenceIllus")
                    .resizable()
                    .scaledToFit()
                    .padding([.horizontal, .bottom], 36)
            }
            if let desc = todayListViewModel.task.desc {
                Text(desc)
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct TodayListView_Previews: PreviewProvider {
    static var previews: some View {
        TodayListView(task: Task(name: "Hehe", repeated: []))
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
    }
}
