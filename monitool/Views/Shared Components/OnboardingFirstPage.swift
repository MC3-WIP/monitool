//
//  OnboardingFirstPage.swift
//  monitool
//
//  Created by Mac-albert on 11/08/21.
//

import SwiftUI

struct OnboardingFirstPage: View {
    var data: OnboardingDataModel
    
    var body: some View {
        VStack {
            GeometryReader{ proxy in
                VStack{
                    Image(data.image)
                        .resizable()
                        .frame(width: 216, height: 216, alignment: .center)
                    Text(data.titleText)
                        .font(.custom("Montserrat-SemiBold", size: 34))
                        .foregroundColor(Color(hex: "4FB0AB"))
                        .padding(.bottom, 16)
                    Text(data.descText)
                        .multilineTextAlignment(.center)
                        .font(.custom("Montserrat-SemiBold", size: 34))
                        .foregroundColor(.gray)
                }.frame(width: proxy.size.width, height: proxy.size.height, alignment: .center )
            }
        }
    .padding()
    }
}

struct OnboardingFirstPage_Previews: PreviewProvider {
    static var data = OnboardingDataModel.dataOnboarding[0]
    static var previews: some View {
        OnboardingFirstPage(data: data)
    }
}
