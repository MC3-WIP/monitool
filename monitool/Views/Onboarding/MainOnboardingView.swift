//
//  AppOnboardingView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 21/07/21.
//

import SwiftUI
import AuthenticationServices

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

struct pageControl: UIViewRepresentable {
	var current  = 0

	func makeUIView(context: UIViewRepresentableContext<pageControl>) -> UIPageControl {
		let page = UIPageControl()
		page.currentPageIndicatorTintColor = .black
		page.numberOfPages = 6
		page.pageIndicatorTintColor = .gray

		return page
	}

	func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<pageControl>) {
		uiView.currentPage = current
	}
}
