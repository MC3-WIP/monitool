//
//  TaskDetailView.swift
//  monitool
//
//  Created by Mac-albert on 03/08/21.
//

import SwiftUI

struct EmployeeReviewView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: EmployeeReviewViewModel
    @ObservedObject var profileViewModel: ProfileViewModel = .shared

    init(task: Task) {
        _viewModel = StateObject(wrappedValue: EmployeeReviewViewModel(task: task))
    }

    @State var totalPage: Int = 3
    @State var datePhoto = "21 Juli 2021 at 15.57"
    @State var proofPage = 0

    @State var showingPinField = false
    @State var isApproving = false
    @State var isPinTrue: Bool?

    var body: some View {
        if viewModel.company == nil {
            VStack(spacing: 24) {
                ProgressView()
                Text("Loading...")
            }
        } else {
            content
        }
    }

    private var content: some View {
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
            PasscodeField(isPinTrue: $isPinTrue) { inputtedPin, _ in
                if isApproving {
                    viewModel.approveTask(
                        pin: inputtedPin,
                        isPinTrue: $isPinTrue,
                        presentation: presentationMode,
                        showPin: $showingPinField,
                        pinInputted: $profileViewModel.pinInputted,
                        isPasscodeFieldDisabled: $profileViewModel.isPasscodeFieldDisabled
                    )
                } else {
                    viewModel.disapproveTask(
                        pin: inputtedPin,
                        isPinTrue: $isPinTrue,
                        presentation: presentationMode,
                        showPin: $showingPinField,
                        pinInputted: $profileViewModel.pinInputted,
                        isPasscodeFieldDisabled: $profileViewModel.isPasscodeFieldDisabled
                    )
                }
            }
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeReviewView(task: Task(name: "EmployeeReview", repeated: []))
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
    }
}
