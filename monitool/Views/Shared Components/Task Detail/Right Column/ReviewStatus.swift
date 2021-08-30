//
//  ReviewerStatus.swift
//  monitool
//
//  Created by Christianto Budisaputra on 20/08/21.
//

import SwiftUI

struct ReviewStatus: View {
    let currentReviewer: Int
    let minReviewer: Int

    var gap: Int {
        if minReviewer - currentReviewer < 0 {
            return 0
        }

        return minReviewer - currentReviewer
    }

    private var reviewerStatus: String {
        "\(currentReviewer) / \(minReviewer)"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Reviewed by:")
                    .foregroundColor(.gray)
                Text(reviewerStatus)
            }.font(.headline)

            HStack {
                ForEach(0 ..< currentReviewer) { _ in
                    Rectangle().cornerRadius(8)
                }.foregroundColor(AppColor.accent)

                ForEach(0 ..< gap) { _ in
                    Rectangle().cornerRadius(8)
                }.foregroundColor(.gray)
            }
            .frame(height: 14)
        }
    }
}

struct ReviewerStatus_Previews: PreviewProvider {
    static var previews: some View {
        ReviewStatus(currentReviewer: 2, minReviewer: 8)
            .previewLayout(.sizeThatFits)
    }
}
