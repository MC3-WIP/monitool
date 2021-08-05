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

    var body: some View{
        VStack(alignment: .center){
            ZStack{
                switch Currentpage{
                case 0:
                    DetailOnboarding(image: "kucing1", titleText: "Monitool", descText: "Test1")
                case 1:
                    DetailOnboarding(image: "kucing2", titleText: "Monitool", descText: "Test1")
                case 2:
                    DetailOnboarding(image: "kucing3", titleText: "Monitool", descText: "Test1")
                case 3:
                    DetailOnboarding(image: "kucing4", titleText: "Monitool", descText: "Test1")
                case 4:
                    DetailOnboarding(image: "kucing5", titleText: "Monitool", descText: "Test1")
                case 5:
                    DetailOnboarding(image: "kucing6", titleText: "Monitool", descText: "Test1")
                default:
                    Text("Error")
                }
            }
            pageControl(current: Currentpage)
                .padding(.bottom, 36.0)
            if Currentpage == 5{
                Button(action: {
                    
                }){
                    NavigationLink(destination: LoginView()){
                        Text("Get Started")
                            .frame(minWidth: 0, maxWidth: 330)
                            .font(.system(size: 28))
                            .padding()
                            .foregroundColor(.blue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.green, lineWidth: 2)
                            )
                    }
                }
            }
            else if Currentpage < 5{
                Button (action: {
                    if Currentpage < 5{
                        Currentpage += 1
                    }
                }){
                    if Currentpage < 5{
                        Text("Continue 􀄫")
                            .frame(minWidth: 0, maxWidth: 330)
                            .font(.system(size: 28))
                            .padding()
                            .foregroundColor(.green)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.green, lineWidth: 2)
                            )
                    }
                }
            }
            Button(action: {
                Currentpage = 5
            }){
                if Currentpage < 5{
                    Text("Skip")
                        .font(.system(size:20))
                        .padding(.top, 28.0)
                }
                else if Currentpage == 6{
                    
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
                            if Currentpage == 5 {
                                
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
            Image(image).resizable().frame(width: 400, height: 400, alignment: .center)
                .padding(.bottom, 20.0)
            Text(titleText)
                .padding(.bottom, 15.0)
                .font(.system(size: 28, weight: .semibold))
            Text(descText)
                .padding(.bottom, 12.0)
                .font(.system(size: 20))
        }
    }
}
