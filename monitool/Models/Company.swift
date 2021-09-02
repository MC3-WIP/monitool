//
//  Company.swift
//  monitool
//
//  Created by Mac-albert on 28/07/21.
//

import FirebaseFirestoreSwift
import Foundation

class Company: Codable {
    @DocumentID var id: String!
    var name: String
    var minReview: Int
    var ownerPin: String
    var hasLoggedIn: Bool?
    var profileImage: String?

    init(name: String, minReview: Int, ownerPin: String, hasLoggedIn: Bool?, profileImage: String?) {
        self.name = name
        self.minReview = minReview
        self.ownerPin = ownerPin
        self.hasLoggedIn = hasLoggedIn ?? true
        self.profileImage = profileImage ?? ""
    }
}
