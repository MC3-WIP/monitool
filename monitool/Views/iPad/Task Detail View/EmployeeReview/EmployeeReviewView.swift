//
//  TaskDetailView.swift
//  monitool
//
//  Created by Mac-albert on 03/08/21.
//

import SwiftUI

struct EmployeeReviewView: View {

    @StateObject var employeeReviewViewModel: EmployeeReviewViewModel
    @Environment(\.presentationMode) var presentationMode

    init (task: Task) {
        _employeeReviewViewModel = StateObject(wrappedValue: EmployeeReviewViewModel(task: task))
    }

    // MARK: INITIALIZE TOTAL PAGE
    @State var totalPage: Int = 3
    @State var datePhoto = "21 Juli 2021 at 15.57"
    @State var proofPage = 0

    @State var showingPinField = false
    @State var isApproving = false

    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    LeftColumn()
                    RightColumn()
                }
            }
            HStack(spacing: 24) {
                dissaprroveButton()
                approveButton()
            }
        }
        .padding()
        .sheet(isPresented: $showingPinField) {
            PasscodeField { inputtedPin, _ in
                if isApproving {
                    employeeReviewViewModel.approveTask(pin: inputtedPin)
                } else {
                    employeeReviewViewModel.disapproveTask(pin: inputtedPin)
                }
                showingPinField = false
                presentationMode.wrappedValue.dismiss()
            }
        }

    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeReviewView(task: (Task(name: "EmployeeReview", repeated: [])))
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
        //        TaskDetailView()
        //
        //            .previewDevice("iPad Air (4th generation)")
        //            .environment(\.horizontalSizeClass, .regular)
    }
}
