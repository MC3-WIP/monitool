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

    var body: some View{
        VStack(alignment: .center){
            ZStack{
                switch Currentpage{
                case 0:
                    DetailOnboarding(image: "Assignillustration", titleText: "Assign", descText: "Assign tasks to make sure your business keep running")
                case 1:
                    DetailOnboarding(image: "MonitorIllustration", titleText: "Monitor", descText: "Monitor your employee works result with ease")
                case 2:
                    DetailOnboarding(image: "ReviewIllustration", titleText: "Review", descText: "You can review and let your employee validates their peer works result on site")
                default:
                    Text("Error")
                }
            }
            PageControl(totalPage: totalPage, current: Currentpage)
                .padding(.bottom, 36.0)
            VStack{
                if Currentpage == 2{
                    Button(action: {
                        
                    }){
                        NavigationLink(destination: LoginView()){
                            Text("Get Started")
                                .frame(minWidth: 0, maxWidth: 330)
                                .font(.system(size: 28))
                                .padding()
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color(hex: "#4FB0AB"), lineWidth: 2)
                                ).background(RoundedRectangle(cornerRadius: 40).fill(Color(hex: "#4FB0AB")))
                        }
                    }
                }
                else if Currentpage < 2{
                    Button (action: {
                        if Currentpage < 2{
                            Currentpage += 1
                        }
                    }){
                        if Currentpage < 2{
                            HStack{
                                Text("Continue")
                                Image(systemName: "arrow.right")
                            }
                            .frame(minWidth: 0, maxWidth: 330)
                            .font(.system(size: 28))
                            .padding()
                            .foregroundColor(Color(hex: "#4FB0AB"))
                            .background(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color(hex: "#4FB0AB"), lineWidth: 2)
                                            )
                        }
                    }
                }
                Button(action: {
                    Currentpage = 2
                }){
                    if Currentpage < 2{
                        Text("Skip")
                            .foregroundColor(Color.black)
                            .font(.system(size:20))
                            .padding(.top, 28.0)
                    }
                    else if Currentpage == 2{
                        Text(" ")
                            .font(.system(size:20))
                            .padding(.top, 28.0)
                    }
                }
            }
            
        }.highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
            .onEnded { value in
                if abs(value.translation.height) < abs(value.translation.width) {
                    if abs(value.translation.width) > 50.0 {
                        if value.translation.width > 0 {
                            if Currentpage == 0{
                                
                            }
                            else{
                                Currentpage -= 1
                            }
                            
                        }
                        else if value.translation.width < 0 {
                            if Currentpage == 2 {
                                
                            }
                            else{
                                Currentpage += 1
                            }
                        }
                    }
                }
            }
        )
    }
    @ViewBuilder
    func DetailOnboarding(image: String, titleText: String, descText: String) -> some View{
        VStack(alignment: .center){
            Image(image).resizable()
                .scaledToFit()
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
