//
//  TaskList.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 04/08/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskList: Codable, Identifiable {
    @DocumentID var id: String!
    let name: String
    let desc: String?
    var repeated: [Bool]?
    var photoReference: [String]?
    
    
    init(name: String, desc: String? = nil, repeated: [Bool]? = nil, photoReference: [String]? = nil) {
        self.name = name
        self.desc = desc
        self.repeated = repeated
        self.photoReference = photoReference
    }
}
