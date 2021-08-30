//
//  OwnerReviewViewBuilder.swift
//  monitool
//
//  Created by Mac-albert on 08/08/21.
//

import SDWebImageSwiftUI
import SwiftUI

extension OwnerReviewView {
    @ViewBuilder func renderLeftColumn() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(ownerReviewViewModel.task.name).font(.title.bold())

            if let image = ownerReviewViewModel.task.photoReference {
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

            if let desc = ownerReviewViewModel.task.desc {
                Text(desc)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.leading)
            }
        }
    }

	@ViewBuilder func reviseButton() -> some View {
        Button {
            TaskRepository.shared.updateStatus(
                taskID: ownerReviewViewModel.task.id,
                status: TaskStatus.revise.title
            ) { _ in
                self.presentationMode.wrappedValue.dismiss()
            }
            ownerReviewViewModel.reviseTask(comment: ownerReviewViewModel.commentTextField)
            TaskRepository.shared.updateLogTask(taskID: ownerReviewViewModel.task.id, titleLog: "Rejected by Owner", timeStamp: Date())
        } label: {
            HStack {
                Image(systemName: "repeat").font(.headline)
                Text("Revise").fontWeight(.semibold)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(AppColor.accent)
            .background(
                RoundedRectangle(cornerRadius: 8).stroke(AppColor.accent, lineWidth: 2)
            )
        }
    }

	@ViewBuilder func approveButton() -> some View {
        Button {
            TaskRepository.shared.updateStatus(
                taskID: ownerReviewViewModel.task.id,
                status: TaskStatus.completed.title
            ) { _ in
                self.presentationMode.wrappedValue.dismiss()
            }
            TaskRepository.shared.updateLogTask(taskID: ownerReviewViewModel.task.id, titleLog: "Approved by Owner", timeStamp: Date())
        } label: {
            HStack {
                Image(systemName: "checkmark").font(.headline)
                Text("Approve").fontWeight(.semibold)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(AppColor.primaryForeground)
            .background(AppColor.accent)
            .cornerRadius(8)
        }
    }
}
