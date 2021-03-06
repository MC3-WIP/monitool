//
//  TaskDetailWaitingOwenerReviewView.swift
//  monitool
//
//  Created by Mac-albert on 06/08/21.
//

import SwiftUI

class OwnerReviewViewModel: TaskDetailViewModel {
    func reviseTask(comment: String? = nil) {
        if let comment = comment, comment != "" {
            taskRepository.updateComment(taskID: task.id, comment: comment)
        }
    }
}

struct OwnerReviewView: View {
	@Environment(\.presentationMode) var presentationMode

	@StateObject var ownerReviewViewModel: OwnerReviewViewModel

	@ObservedObject var role: RoleService = .shared

	init(task: Task) {
		_ownerReviewViewModel = StateObject(wrappedValue: OwnerReviewViewModel(task: task))
	}

	var body: some View {
		VStack {
			ScrollView {
				HStack(alignment: .top, spacing: 24) {
					renderLeftColumn()

					VStack(alignment: .leading, spacing: 24) {
						ProofOfWork(task: ownerReviewViewModel.task)

						RightColumn<OwnerReviewViewModel>(
							components: role.isOwner ? [
								.picText,
								.notesText,
								.commentTextField
							] : [
								.picText,
								.notesText
							],
							viewModel: ownerReviewViewModel
						)
					}
				}
			}

			if role.isOwner {
				HStack(spacing: 24) {
					reviseButton()
					approveButton()
				}
			}
		}.padding([.top, .leading, .trailing], 24.0)
	}
}

struct OwnerReviewView_Preview: PreviewProvider {
    static var previews: some View {
        OwnerReviewView(task: Task(name: "OwnerReview"))
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
    }
}
