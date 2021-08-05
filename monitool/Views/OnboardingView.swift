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
    @Binding var userHasBoarded: Bool
    
    var body: some View {
        if userAuth.isLoggedIn {
            if userHasBoarded {
                MainView()
            } else {
                CompanyOnboarding(userHasBoarded: $userHasBoarded)
                EmployeeListView()
            }
        } else {
            //                SidebarView()
            //                DetailView()
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(userHasBoarded: .constant(true)).previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        OnboardingView(userHasBoarded: .constant(true))
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
