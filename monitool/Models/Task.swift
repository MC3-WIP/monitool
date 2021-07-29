//
//  Task.swift
//  monitool
//
//  Created by Devin Winardi on 27/07/21.
//

import Foundation
import FirebaseFirestoreSwift

class Task: Codable, Identifiable {
    @DocumentID var id: String!
    var name: String
    var status: TaskStatus?
    var createdAt: Date
    var repeated: [Bool]
    var desc: String?
    var proof: Data?
    var notes: String?
    
    var pic: Employee?
    var reviewer: [Employee]?
    
    init(name: String,desc: String? = nil, repeated: [Bool]){
        self.name = name
        self.desc = desc
        self.status = .ongoing
        self.repeated = repeated
        self.createdAt = Date()
    }
}

enum TaskStatus: Int, Codable{
    case ongoing = 0
    case waitingPeerReview = 1
    case waitingOwnerReview = 2
    case revised = 3
    case completed = 4
}
