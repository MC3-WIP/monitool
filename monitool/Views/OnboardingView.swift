//
//  ContentView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 21/07/21.
//

import SwiftUI
import AuthenticationServices

struct OnboardingView: View {
    @ObservedObject var userAuth: AuthService = .shared
    
	var body: some View {
        NavigationView{
            if userAuth.isLoggedIn {
                CompanyOnboarding()
            } else {
//                SidebarView()
                CompanyOnboarding()
//                DetailView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        OnboardingView()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
    }

}

struct pageControl: UIViewRepresentable{
    
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