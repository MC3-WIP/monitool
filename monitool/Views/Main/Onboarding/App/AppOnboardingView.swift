//
//  OnboardingDetailView.swift
//  monitool
//
//  Created by Mac-albert on 03/08/21.
//

import Foundation
import SwiftUI

struct AppOnboardingView: View{
    @State var Currentpage = 0
    @State var totalPage = 3
    
    @State private var onBoardingDone = false
    var data = OnboardingDataModel.dataOnboarding
    
    var body: some View{
        OnboardingViewPure(data: data, doneFunction: {
            self.onBoardingDone = true
            print("done")
        })
    }
    @ViewBuilder
    func DetailOnboarding(image: String, titleText: String, descText: String, proxy: GeometryProxy) -> some View{
        VStack(alignment: .center){
            Image(image)
                .frame(width: proxy.size.height * 0.3, height: proxy.size.height * 0.3)
                .padding(.bottom, 20.0)
            Text(titleText)
                .padding(.bottom, 15.0)
                .font(.system(size: 28, weight: .semibold))
            Text(descText)
                .padding(.bottom, 12.0)
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
        }
        
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
