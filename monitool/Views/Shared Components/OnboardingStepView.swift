//
//  OnboardingStepView.swift
//  Onboarding
//
//  Created by Augustinas Malinauskas on 06/07/2020.
//  Copyright © 2020 Augustinas Malinauskas. All rights reserved.
//

import SwiftUI

struct OnboardingStepView: View {
    var data: OnboardingDataModel

    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack {
                    Image(data.image)
                        .resizable()
                        .frame(width: proxy.size.height * 0.725, height: proxy.size.height * 0.7, alignment: .center)
                        .padding(.bottom, 50)

                    Text(data.titleText)
                        .font(.system(size: 25, design: .rounded))
                        .fontWeight(.bold)
                    Text(data.descText)
                        .frame(width: proxy.size.width, height: proxy.size.height * 0.2, alignment: .center)
                        .font(.system(size: 17))
                        .multilineTextAlignment(.center)
                }.frame(width: proxy.size.width, height: proxy.size.height, alignment: .center )
            }

        }
    .padding()
    }
}

struct OnboardingStepView_Previews: PreviewProvider {
    static var data = OnboardingDataModel.dataOnboarding[0]
    static var previews: some View {
        OnboardingStepView(data: data)
    }
}
