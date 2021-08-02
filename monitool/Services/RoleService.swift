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
	private init() {}

	var isOwner: Bool {
		true
	}

}
