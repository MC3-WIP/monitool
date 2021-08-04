//
//  RoleService.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import Foundation

final class RoleService: ObservableObject {
	// Singleton Configuration
	static let shared = RoleService()
    
    @Published var isOwner: Bool = true{
        didSet {
            UserDefaults.standard.set(isOwner, forKey: "isOwner")
        }
    }
    
    init() {
        self.isOwner = UserDefaults.standard.bool(forKey: "isOwner")
    }
    
    func switchRole() {
        // login request... on success:
        let current = UserDefaults.standard.bool(forKey: "isOwner")
        UserDefaults.standard.set(!current, forKey: "isOwner")
        isOwner = UserDefaults.standard.bool(forKey: "isOwner")
    }
    
}
