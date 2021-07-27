//
//  Task.swift
//  monitool
//
//  Created by Devin Winardi on 27/07/21.
//

import Foundation
import FirebaseFirestoreSwift

class Task:Codable{
    @DocumentID var id: String?
    var name: String
    var desc: String?
    var status: String
    var proof: Data?
    var notes: String?
    var createdAt: Date
    var repeated: [Int]
    
//    var pic: Employee
//    var reviewer: [Employee]
    
    init(name: String, status: String, repeated: [Int]){
        self.name = name
        self.status = status
        self.repeated = repeated
        self.createdAt = Date()
    }
    
    init(name: String, desc: String, status: String, repeated: [Int]){
        self.name = name
        self.desc = desc
        self.status = status
        self.repeated = repeated
        self.createdAt = Date()
    }
    
    func updateStatus(status: String){
        self.status = status
    }
    
    func updateNotes(notes: String){
        self.notes = notes
    }
}
