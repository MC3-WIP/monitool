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
    var doneFunction: () -> ()
    
    @State var slideGesture: CGSize = CGSize.zero
    @State var curSlideIndex = 0
    var distance: CGFloat = UIScreen.main.bounds.size.width
    
    
    func nextButton() {
        if self.curSlideIndex == self.data.count - 1 {
            doneFunction()
            return
        }
        
        if self.curSlideIndex < self.data.count - 1 {
            withAnimation {
                self.curSlideIndex += 1
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            
            GeometryReader{proxy in
                VStack(spacing: 30){
                    ZStack(alignment: .center) {
                        ForEach(0..<data.count) { i in
                            if i == 0{
                                OnboardingFirstPage(data: self.data[i])
                                    .frame(height: proxy.size.height * 0.7, alignment: .center)
                                    .offset(x: CGFloat(i) * self.distance)
                                    .offset(x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance)
                                    .animation(.spring())
                                    .gesture(DragGesture().onChanged{ value in
                                        self.slideGesture = value.translation
                                    }
                                    .onEnded{ value in
                                        if self.slideGesture.width < -50 {
                                            if self.curSlideIndex < self.data.count - 1 {
                                                withAnimation {
                                                    self.curSlideIndex += 1
                                                }
                                            }
                                        }
                                        if self.slideGesture.width > 50 {
                                            if self.curSlideIndex > 0 {
                                                withAnimation {
                                                    self.curSlideIndex -= 1
                                                }
                                            }
                                        }
                                        self.slideGesture = .zero
                                    })
                            }
                            else{
                                OnboardingStepView(data: self.data[i])
                                    .frame(height: proxy.size.height * 0.7, alignment: .center)
                                    .offset(x: CGFloat(i) * self.distance)
                                    .offset(x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance)
                                    .animation(.spring())
                                    .gesture(DragGesture().onChanged{ value in
                                        self.slideGesture = value.translation
                                    }
                                    .onEnded{ value in
                                        if self.slideGesture.width < -50 {
                                            if self.curSlideIndex < self.data.count - 1 {
                                                withAnimation {
                                                    self.curSlideIndex += 1
                                                }
                                            }
                                        }
                                        if self.slideGesture.width > 50 {
                                            if self.curSlideIndex > 0 {
                                                withAnimation {
                                                    self.curSlideIndex -= 1
                                                }
                                            }
                                        }
                                        self.slideGesture = .zero
                                    })
                            }
                        }
                    }
                    self.progressView()
                    SignIn()
                }
            }
        }
    }
    
    func arrowView() -> some View {
        Group {
            if self.curSlideIndex == self.data.count - 1 {
                HStack {
                    Text("Done")
                        .font(.system(size: 27, weight: .medium, design: .rounded))
                        .foregroundColor(Color(.systemBackground))
                }
                .frame(width: 120, height: 50)
                .background(Color(.label))
                .cornerRadius(25)
            } else {
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .foregroundColor(Color(.label))
                    .scaledToFit()
                    .frame(width: 50)
            }
        }
    }
    
    func progressView() -> some View {
        HStack {
            ForEach(0..<data.count) { i in
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
