//
//  OnboardingViewPure.swift
//  Onboarding
//
//  Created by Augustinas Malinauskas on 06/07/2020.
//  Copyright © 2020 Augustinas Malinauskas. All rights reserved.
//

import SwiftUI

struct OnboardingViewPure: View {
    var data: [OnboardingDataModel]
    var doneFunction: () -> Void

    @State var slideGesture = CGSize.zero
    @State var curSlideIndex = 0

    var distance: CGFloat = UIScreen.main.bounds.size.width

    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(.all)

            GeometryReader { proxy in
                VStack(spacing: 30) {
                    ZStack(alignment: .center) {
                        ForEach(0 ..< data.count) { i in
                            if i == 0 {
                                OnboardingFirstPage(data: self.data[i])
                                    .frame(height: proxy.size.height * 0.7, alignment: .center)
                                    .offset(x: CGFloat(i) * self.distance)
                                    .offset(x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance)
                                    .animation(.spring())
                            } else {
                                OnboardingStepView(data: self.data[i])
                                    .frame(height: proxy.size.height * 0.7, alignment: .center)
                                    .offset(x: CGFloat(i) * self.distance)
                                    .offset(x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance)
                                    .animation(.spring())
                            }
                        }
                    }
                    self.progressView()
                    SignIn()
                }
                .contentShape(Rectangle())
                .gesture(DragGesture().onChanged { value in
                    self.slideGesture = value.translation
                }
                .onEnded { value in
                    if abs(value.translation.height) < abs(value.translation.width) {
                        if abs(value.translation.width) > 50 {
                            if value.translation.width > 0 {
                                if curSlideIndex == 0 {
                                } else {
                                    withAnimation { self.curSlideIndex -= 1
                                    }
                                }
                            }
                            if value.translation.width < 0 {
                                if curSlideIndex == data.count - 1 {
                                } else {
                                    withAnimation { self.curSlideIndex += 1
                                    }
                                }
                            }
                            self.slideGesture = .zero
                        }
                    }
                }
                )
            }
        }
    }

    func progressView() -> some View {
        HStack {
            ForEach(0 ..< data.count) { i in
                Circle()
                    .scaledToFit()
                    .frame(width: 10)
                    .foregroundColor(self.curSlideIndex >= i ? Color(hex: "4EB0AB") : Color(hex: "F0F9F8"))
            }
        }
    }
}

struct OnboardingViewPure_Previews: PreviewProvider {
    static let sample = OnboardingDataModel.dataOnboarding
    static var previews: some View {
        OnboardingViewPure(data: sample, doneFunction: { print("done") })
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewLayout(.fixed(width: 1112, height: 834))
    }
}
