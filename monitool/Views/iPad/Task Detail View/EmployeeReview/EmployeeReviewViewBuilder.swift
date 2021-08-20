//
//  EmployeeReivewViewBuilder.swift
//  monitool
//
//  Created by Mac-albert on 08/08/21.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

extension EmployeeReviewView {
    @ViewBuilder func LeftColumn() -> some View {
        GeometryReader { metric in
            VStack {
                Text(employeeReviewViewModel.task.name)
                    .font(.system(size: 28, weight: .bold))
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 28, maxHeight: 32, alignment: .leading)
                if let image = employeeReviewViewModel.task.photoReference {
                    WebImage(url: URL(string: image))
                        .resizable()
                        .frame(width: metric.size.width * 0.8, height: metric.size.width * 0.8, alignment: .leading)
                } else {
                    Image("MonitoolEmptyReferenceIllus")
                        .resizable()
                        .frame(width: metric.size.width * 0.8, height: metric.size.width * 0.8, alignment: .leading)
                }
                if let desc = employeeReviewViewModel.task.desc {
                    Text(desc)
                        .frame(width: metric.size.width * 0.8, alignment: .topLeading)
                        .font(.system(size: 17))
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
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

				VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("PIC: ")
							.foregroundColor(.gray)
                            .bold()
                        Text(employeeReviewViewModel.pic?.name ?? "-")
					}
                    HStack {
                        Text("Notes: ")
							.foregroundColor(.gray)
                            .bold()
                        Text(employeeReviewViewModel.task.notes ?? "-")
					}
					if let company = employeeReviewViewModel.company {
						ReviewerStatus(currentReviewer: employeeReviewViewModel.reviewer.count, minReviewer: company.minReview)
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

    @ViewBuilder func ProofOfWork(image: String, date: String, metricSize: GeometryProxy, datePhoto: String) -> some View {
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
