//
//  IphoneEmployeeReview.swift
//  monitool
//
//  Created by Mac-albert on 11/08/21.
//
import SwiftUI
import SDWebImageSwiftUI

struct IphoneEmployeeReview: View {
	@StateObject var viewModel: EmployeeReviewViewModel

	init(task: Task) {
		_viewModel = StateObject(wrappedValue: EmployeeReviewViewModel(task: task))
	}

	var body: some View {
		if viewModel.company != nil {
			content
		} else {
			VStack(spacing: 24) {
				ProgressView()
				Text("Loading...")
			}
		}
	}

	private var content: some View {
		ScrollView {
			LazyVStack(alignment: .leading, spacing: 32) {
				// Tentang Task
				VStack(alignment: .leading) {
					Text(viewModel.title)
						.font(.largeTitle)
						.bold()
					Text(viewModel.desc)
				}

				// Proof of Work
				VStack(alignment: .leading) {
					Text("Proof of Work")
						.font(.title3)
						.bold()
						.foregroundColor(.gray)

					Image("MonitoolEmptyReferenceIllus")
						.resizable()
						.scaledToFill()
						.overlay(RoundedRectangle(cornerRadius: 8).stroke(AppColor.accent, lineWidth: 2))
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
						Text(viewModel.task.notes ?? "-")
					}

					// Review Status
					if let company = viewModel.company {
						ReviewerStatus(currentReviewer: viewModel.reviewer.count, minReviewer: company.minReview)
					}
				}

				// Reference Image
				if let referenceImage = viewModel.photoReference {
					VStack(alignment: .leading) {
						Text("Photo Reference")
							.font(.title3)
							.bold()
							.foregroundColor(.gray)
						WebImage(url: URL(string: referenceImage))
							.resizable()
							.placeholder(Image("MonitoolEmptyReferenceIllus"))
							.indicator { _, _ in
								ProgressView()
							}
							.scaledToFill()
							.cornerRadius(8)
					}
				} else {
					Image("MonitoolEmptyReferenceIllus")
						.resizable()
						.scaledToFill()
				}
			}.padding()
		}.navigationBarTitle("Waiting Employee Review", displayMode: .inline)
	}
}
