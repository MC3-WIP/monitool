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

	@ObservedObject var role: RoleService = .shared
    @ObservedObject var profileViewModel: ProfileViewModel = .shared

    init(task: Task) {
        _viewModel = StateObject(wrappedValue: EmployeeReviewViewModel(task: task))
    }

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
                HStack(alignment: .top, spacing: 24) {
                    renderLeftColumn()
                    VStack(alignment: .leading, spacing: 24) {
                        ProofOfWork(task: viewModel.task)

                        RightColumn<EmployeeReviewViewModel>(
                            components: role.isOwner ? [
                                .picText,
                                .notesText
                            ] : [
                                .picText,
                                .notesText,
                                .reviewStatus
                            ],
                            viewModel: viewModel
                        )
                    }
                }
            }
            if !role.isOwner {
              HStack(spacing: 24) {
                  dissaprroveButton()
                  approveButton()
              }
            }
        }
        .padding([.top, .leading, .trailing], 24.0)
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
