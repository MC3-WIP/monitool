//
//  Company.swift
//  monitool
//
//  Created by Mac-albert on 28/07/21.
//

import Foundation
import FirebaseFirestoreSwift

class Company: Codable{
    @DocumentID var id: String!

    var name: String
    var minReview: Int
    var hasLoggedIn: Bool?

    init(name: String, minReview: Int, hasLoggedIn: Bool?) {
        self.name = name
        self.minReview = minReview
        self.hasLoggedIn = hasLoggedIn ?? true
    }
}
