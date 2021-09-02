//
//  IphoneEmployeeReview.swift
//  monitool
//
//  Created by Mac-albert on 11/08/21.
//
import SDWebImageSwiftUI
import SwiftUI

struct IphoneEmployeeReview: View {
    @StateObject var viewModel: EmployeeReviewViewModel

    init(task: Task) {
        _viewModel = StateObject(wrappedValue: EmployeeReviewViewModel(task: task))
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                // About Task
                Text(viewModel.title)
                    .font(.largeTitle)
                    .bold()

                // Proof of Work
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
                        Text(viewModel.picName)
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

                // Reference Image
                PhotoReference(url: viewModel.photoReference)

                // Task Desc
                Text(viewModel.desc)
            }.padding()
        }.navigationBarTitle("Waiting Employee Review", displayMode: .inline)
    }
}
