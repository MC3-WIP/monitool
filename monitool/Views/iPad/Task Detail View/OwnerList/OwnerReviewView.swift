//
//  TaskDetailWaitingOwenerReviewView.swift
//  monitool
//
//  Created by Mac-albert on 06/08/21.
//

import SwiftUI

struct OwnerReviewView: View {
    @StateObject var OwnerViewModel: TodayListViewModel
    @StateObject var taskDetailViewModel: TaskDetailViewModel
    @ObservedObject var role: RoleService = .shared
    @ObservedObject var employeeRepository: EmployeeRepository = .shared
    @ObservedObject var taskViewModel = TaskViewModel()
    @Environment(\.presentationMode) var presentationMode

    init(task: Task) {
        _taskDetailViewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
        _OwnerViewModel = StateObject(wrappedValue: TodayListViewModel(task: task))
    }

    private let notes = "Sudah Pak Bos"
    private let pic = "Mawar"

    @State var totalPage: Int = 3
    @State var datePhoto = "21 Juli 2021 at 15.57"
    @State private var comment: String = ""
    @State var proofPage = 0

    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    LeftColumn()
                    RightColumn()
                }
                .frame(height: 680)
            }

            HStack(spacing: 24) {
                reviseButton()
                approveButton()
            }
            .padding()
        }
    }
}

struct OwnerReviewView_Preview: PreviewProvider {
    static var previews: some View {
        OwnerReviewView(task: Task(name: "OwnerReview", repeated: []))
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
    }
}
