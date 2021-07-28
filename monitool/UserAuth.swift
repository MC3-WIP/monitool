//
//  UserAuth.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 28/07/21.
//

import Foundation
import SwiftUI

class UserAuth: ObservableObject {
    static let shared = UserAuth()
    @Published var isLoggedIn: Bool {
            didSet {
                UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
            }
        }
        
    init() {
        self.isLoggedIn = UserDefaults.standard.object(forKey: "isLoggedIn") as? Bool ?? false
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
    
}
