//
//  ReviseViewBuilder.swift
//  monitool
//
//  Created by Mac-albert on 08/08/21.
//

import Foundation
import SDWebImageSwiftUI
import SwiftUI

extension ReviseView {
	@ViewBuilder func renderLeftColumn() -> some View {
		VStack(alignment: .leading) {
			// Task Title
			Text(reviseViewModel.title).font(.title.bold())

			// Reference Image
            PhotoReference(url: reviseViewModel.photoReference)

			Text(reviseViewModel.desc)
		}
	}

    @ViewBuilder func reviseButton() -> some View {
        Button {
			TaskRepository.shared.updateStatus(
				taskID: reviseViewModel.task.id,
				status: TaskStatus.revise.title
			) { _ in
				self.presentationMode.wrappedValue.dismiss()
			}
            reviseViewModel.reviseTask(comment: reviseViewModel.commentTextField)
            TaskRepository.shared.updateLogTask(
                taskID: reviseViewModel.task.id,
                titleLog: "Rejected by Owner",
                timeStamp: Date()
            )
        } label: {
            HStack {
                Image(systemName: "repeat")
                Text("Revise")
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .font(.system(size: 17, weight: .semibold))
            .padding()
            .foregroundColor(Color(hex: "#4FB0AB"))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#4FB0AB"), lineWidth: 2)
            )
        }
    }

	func approveButton() -> some View {
        Button {
			TaskRepository.shared.updateStatus(
				taskID: reviseViewModel.task.id,
				status: TaskStatus.completed.title
			) { _ in
				self.presentationMode.wrappedValue.dismiss()
			}
            TaskRepository.shared.updateLogTask(
                taskID: reviseViewModel.task.id,
                titleLog: "Approved by Owner",
                timeStamp: Date()
            )
        } label: {
            HStack {
                Image(systemName: "checkmark")
                Text("Approve")
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .font(.system(size: 17, weight: .semibold))
            .padding()
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#4FB0AB"), lineWidth: 2)
            ).background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#4FB0AB")))
        }
    }
}
