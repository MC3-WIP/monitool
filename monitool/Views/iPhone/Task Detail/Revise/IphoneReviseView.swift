//
//  IphoneReviseView.swift
//  monitool
//
//  Created by Mac-albert on 12/08/21.
//
import SDWebImageSwiftUI
import SwiftUI

struct IphoneReviseView: View {
    @StateObject var viewModel: ReviseViewModel

    @Environment(\.presentationMode) var presentationMode

    @State var notes = ""

    init(task: Task) {
        _viewModel = StateObject(wrappedValue: ReviseViewModel(task: task))
    }

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 24) {
                Text(viewModel.task.name)
                    .font(.system(size: 28, weight: .bold))
                Text("Proof of Work")
                    .font(.title3.weight(.bold))
                    .foregroundColor(.gray)

                if let proofOfWork = viewModel.proofOfWork, proofOfWork.count > 0 {
                    Carousel(images: viewModel.task.proof)
                } else {
                    Image("AddPhoto")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .padding(36)
                }

                // Detail
                VStack(alignment: .leading, spacing: 16) {
                    // PIC
                    HStack {
                        Text("PIC: ")
                            .foregroundColor(.gray)
                            .bold()
                        Text(viewModel.pic?.name ?? "-")
                    }

                    // Notes
                    HStack {
                        Text("Notes: ")
                            .foregroundColor(.gray)
                            .bold()
                        Text(viewModel.notes)
                    }

                    // Review Status
                    if let company = viewModel.company, company.minReview > 0 {
                        ReviewStatus(currentReviewer: viewModel.reviewer.count, minReviewer: company.minReview)
                    }
                }

                VStack(alignment: .leading) {
                    Text("Comment").foregroundColor(.gray).font(.title3).bold()

                    TextField("Type your comment here", text: $notes)
                        .padding()
                        .frame(minHeight: 120, alignment: .topLeading)
                        .background(AppColor.lightAccent)
                        .modifier(
                            RoundedEdge(
                                width: 2,
                                color: AppColor.accent,
                                cornerRadius: 8)
                        )
                }.padding(.bottom)

                PhotoReference(url: viewModel.task.photoReference)

                Text(viewModel.desc).multilineTextAlignment(.leading)

                VStack(spacing: 12) {
                    approveButton()
                    reviseButton()
                }.padding(.vertical)
            }
        }
        .navigationBarTitle("Waiting Owner Review", displayMode: .inline)
        .padding()
    }

    @ViewBuilder func reviseButton() -> some View {
        Button {
            TaskRepository.shared.updateStatus(
                taskID: viewModel.task.id,
                status: TaskStatus.revise.title
            )

            self.presentationMode.wrappedValue.dismiss()

            TaskRepository.shared.updateLogTask(
                taskID: viewModel.task.id,
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
            .foregroundColor(AppColor.accent)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppColor.accent, lineWidth: 2)
                    .padding(.horizontal, 2)
            )
        }
    }

    @ViewBuilder func approveButton() -> some View {
        Button {
            TaskRepository.shared.updateStatus(
                taskID: viewModel.task.id,
                status: TaskStatus.completed.title
            )

            self.presentationMode.wrappedValue.dismiss()

            TaskRepository.shared.updateLogTask(
                taskID: viewModel.task.id,
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
                AppColor.accent
            )
            .cornerRadius(8)
        }
    }
}

struct IphoneReviseView_Previews: PreviewProvider {
    static var previews: some View {
        IphoneReviseView(task: Task(name: "Revise Iphone"))
    }
}
