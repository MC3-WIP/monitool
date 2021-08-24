//
//  EmployeeReivewViewBuilder.swift
//  monitool
//
//  Created by Mac-albert on 08/08/21.
//

import Foundation
import SDWebImageSwiftUI
import SwiftUI

extension EmployeeReviewView {
    @ViewBuilder func LeftColumn() -> some View {
        // About Task
        VStack(alignment: .leading) {
            // Task Title
            Text(viewModel.title)
                .font(.largeTitle)
                .bold()

            // Reference Image
            if let image = viewModel.photoReference {
                WebImage(url: URL(string: image))
                    .resizable()
                    .placeholder(Image("MonitoolEmptyReferenceIllus"))
                    .indicator { _, _ in
                        ProgressView()
                    }
                    .transition(.fade)
                    .aspectRatio(1, contentMode: .fill)
            } else {
                Image("MonitoolEmptyReferenceIllus")
                    .resizable()
                    .scaledToFill()
            }

            // Task Desc
            Text(viewModel.desc)
        }
    }

    @ViewBuilder func RightColumn() -> some View {
        GeometryReader { matric in
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Proof of Work")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.gray)

                    proofOfWorkComponent(matric: matric, proofPage: proofPage, totalPage: totalPage, datePhoto: datePhoto)
                }

                // Detail
                VStack(alignment: .leading) {
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
                    if let company = viewModel.company {
                        ReviewerStatus(currentReviewer: viewModel.reviewer.count, minReviewer: company.minReview)
                    }
                }
            }
            .padding()
        }
    }

    @ViewBuilder func proofOfWorkComponent(matric: GeometryProxy, proofPage: Int, totalPage: Int, datePhoto: String) -> some View {
        VStack {
            ZStack {
                switch proofPage {
                case 0:
                    ProofOfWork(
                        image: "DefaultRefference",
                        date: "21 Jul 2021 at 15:57",
                        metricSize: matric,
                        datePhoto: datePhoto
                    )
                case 1:
                    ProofOfWork(
                        image: "DefaultRefference",
                        date: "21 Jul 2021 at 15:57",
                        metricSize: matric,
                        datePhoto: datePhoto
                    )
                case 2:
                    ProofOfWork(
                        image: "DefaultRefference",
                        date: "21 Jul 2021 at 15:57",
                        metricSize: matric,
                        datePhoto: datePhoto
                    )
                default:
                    Image("MonitoolAddPhotoIllustration")
                }
            }
            .highPriorityGesture(
                DragGesture(minimumDistance: 25, coordinateSpace: .local)
                    .onEnded { value in
                        if abs(value.translation.height) < abs(value.translation.width) {
                            if abs(value.translation.width) > 50.0 {
                                if value.translation.width > 0 {
                                    if proofPage == 0 {
                                    } else {
                                        self.proofPage -= 1
                                    }
                                } else if value.translation.width < 0 {
                                    if proofPage == totalPage - 1 {
                                    } else {
                                        self.proofPage += 1
                                    }
                                }
                            }
                        }
                    }
            )
            PageControl(totalPage: totalPage, current: proofPage)
        }
        .padding(.vertical)
        .background(Color(hex: "F0F9F8"))
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(hex: "4EB0AB"), lineWidth: 1)
        )
    }

    @ViewBuilder func ProofOfWork(image _: String, date _: String, metricSize: GeometryProxy, datePhoto: String) -> some View {
        VStack {
            Image("MonitoolAddPhotoIllustration")
                .resizable()
                .frame(width: metricSize.size.width * 0.7, height: metricSize.size.width * 0.7)
            Text(datePhoto)
                .font(.system(size: 11))
                .frame(width: metricSize.size.width * 0.7, height: 12, alignment: .leading)
        }
    }

    @ViewBuilder func approveButton() -> some View {
        Button {
            showingPinField = true
            isApproving = true
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

    @ViewBuilder func dissaprroveButton() -> some View {
        Button {
            showingPinField = true
            isApproving = false
        } label: {
            HStack {
                Image(systemName: "xmark")
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
}
