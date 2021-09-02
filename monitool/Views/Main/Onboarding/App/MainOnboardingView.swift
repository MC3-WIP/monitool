//
//  AppOnboardingView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 21/07/21.
//

import AuthenticationServices
import SwiftUI

struct MainOnboardingView: View {
    @ObservedObject var userAuth: AuthService = .shared

    var body: some View {
        if userAuth.isLoggedIn {
            if userAuth.hasLoggedIn {
                MainView()
            } else {
                CompanyOnboardingView()
            }
        } else {
            NavigationView {
                AppOnboardingView()
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        MainOnboardingView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
        MainOnboardingView()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
    }
}
