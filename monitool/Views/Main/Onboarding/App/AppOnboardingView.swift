//
//  OnboardingDetailView.swift
//  monitool
//
//  Created by Mac-albert on 03/08/21.
//

import Foundation
import SwiftUI

struct AppOnboardingView: View {
    var data = OnboardingDataModel.dataOnboarding

    var body: some View {
        OnboardingViewPure(data: data, doneFunction: {
            print("done")
        })
    }
}

struct AppOnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        AppOnboardingView()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
        AppOnboardingView()
            .previewDevice("iPhone 12")
    }
}
