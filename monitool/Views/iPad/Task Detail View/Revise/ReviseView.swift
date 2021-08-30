//
//  ReviseTaskDetailView.swift
//  monitool
//
//  Created by Mac-albert on 07/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

class ReviseViewModel: TaskDetailViewModel {
}

struct ReviseView: View {
	@Environment(\.presentationMode) var presentationMode

	@StateObject var reviseViewModel: ReviseViewModel

	@ObservedObject var role: RoleService = .shared

	init(task: Task) {
		_reviseViewModel = StateObject(wrappedValue: ReviseViewModel(task: task))
	}

	var body: some View {
		VStack {
			ScrollView {
				HStack(alignment: .top, spacing: 24) {
					renderLeftColumn()

					VStack(alignment: .leading, spacing: 24) {
						ProofOfWork(task: reviseViewModel.task)

						RightColumn<ReviseViewModel>(
							components: role.isOwner ? [
								.picText,
								.notesText,
								.commentTextField
							] : [
								.picText,
								.notesTextField,
								.commentText
							],
							viewModel: reviseViewModel
						)

						if !role.isOwner {
							Button("Submit") {
								// Update photo & notes

								presentationMode.wrappedValue.dismiss()
							}.buttonStyle(PrimaryButtonStyle())
						}
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

struct ReviseTaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviseView(task: Task(name: "Revise Page"))
    }
}
