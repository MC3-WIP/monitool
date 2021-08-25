//
//  monitoolApp.swift
//  monitool
//
//  Created by Christianto Budisaputra on 21/07/21.
//

import Firebase
import SwiftUI

@main
struct MonitoolApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            MainOnboardingView()
        }
    }
}
