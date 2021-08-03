//
//  monitoolApp.swift
//  monitool
//
//  Created by Christianto Budisaputra on 21/07/21.
//

import SwiftUI
import Firebase

@main
struct MonitoolApp: App {
	@AppStorage("userHasBoarded") var userHasBoarded = false

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
			OnboardingView(userHasBoarded: $userHasBoarded)
				.accentColor(.AppColor.primary)
        }
    }
}
