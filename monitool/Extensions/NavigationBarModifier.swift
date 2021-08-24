//
//  NavigationBar.swift
//  monitool
//
//  Created by Christianto Budisaputra on 06/08/21.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(AppColor.secondary)
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(AppColor.primaryBackground)]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(AppColor.primaryBackground)]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    AppColor.secondary
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    func styleNavigationBar() -> some View {
        modifier(NavigationBarModifier())
    }
}
