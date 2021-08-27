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
    @ViewBuilder func renderLeftColumn() -> some View {
        // About Task
        VStack(alignment: .leading) {
            // Task Title
            Text(viewModel.title).font(.title.bold())

            // Reference Image
            if let image = viewModel.photoReference {
                WebImage(url: URL(string: image))
                    .resizable()
                    .indicator { _, _ in
                        ProgressView()
                    }
                    .scaledToFit()
            } else {
                Image("MonitoolEmptyReferenceIllus")
                    .resizable()
                    .scaledToFill()
                    .padding([.horizontal, .bottom], 36)
            }

            // Task Desc
            Text(viewModel.desc)
                .font(.system(size: 17))
        }.frame(minWidth: 0, maxWidth: .infinity)
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
