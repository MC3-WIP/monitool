//
//  AuthenticationService.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 28/07/21.
//

import Foundation
import SwiftUI

class AuthService: ObservableObject {
	static let shared = AuthService()

	@Published var isLoggedIn: Bool {
		didSet {
			UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
		}
	}

    @Published var hasLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(hasLoggedIn, forKey: "hasLoggedIn")
        }
    }

	init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        self.hasLoggedIn = UserDefaults.standard.bool(forKey: "hasLoggedIn")
	}

	func login() {
		// login request... on success:
		UserDefaults.standard.set(true, forKey: "isLoggedIn")
		isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
	}

	func logout() {
		// login request... on success:
		UserDefaults.standard.set(false, forKey: "isLoggedIn")
		isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
	}

    func hasLogin() {
        UserDefaults.standard.set(true, forKey: "hasLoggedIn")
        hasLoggedIn = UserDefaults.standard.bool(forKey: "hasLoggedIn")
    }
}
