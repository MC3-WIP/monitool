//
//  monitoolApp.swift
//  monitool
//
//  Created by Christianto Budisaputra on 21/07/21.
//

import Firebase
import SwiftUI
import UserNotifications

@main
struct MonitoolApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        
        WindowGroup {
            MainOnboardingView()
        }
    }
}
