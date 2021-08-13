//
//  RoleService.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import Foundation

final class RoleService: ObservableObject {
	enum Role {
		case owner,
			 employee
	}
	// Singleton Configuration
	static let shared = RoleService()
    
    @Published var isOwner: Bool = true {
        didSet {
            UserDefaults.standard.set(isOwner, forKey: "isOwner")
        }
    }
    
    init() {
        self.isOwner = UserDefaults.standard.bool(forKey: "isOwner")
    }
    
	func switchRole(to role: Role) {
		isOwner = role == .owner
    }
    
}
