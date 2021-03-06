//
//  Task.swift
//  monitool
//
//  Created by Devin Winardi on 27/07/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class Task: Codable, Identifiable, Hashable {
    @DocumentID var id: String!
    let name: String
    let desc: String?
    let createdAt: Date

    var status: TaskStatus
    var proof: [String]?
    var notes: String?
    var comment: String?

    var titleLog: [String]
    var timeStampLog: [Date]

    var pic: DocumentReference?
    var approvingReviewer: [DocumentReference]?
    var disapprovingReviewer: [DocumentReference]?

    var isHistory: Bool

    var photoReference: String?

    var parentId: String?

    init(
        name: String,
        description: String? = nil,
        photoReference: String? = nil,
        parentId: String? = nil
    ) {
        self.name = name
        desc = description
        createdAt = Date()
        status = .todayList
        isHistory = false
        self.photoReference = photoReference
        self.parentId = parentId
        self.titleLog = ["\(name) created by Owner"]
        self.timeStampLog = [Date()]
    }

    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.createdAt == rhs.createdAt &&
            lhs.status == rhs.status &&
            rhs.isHistory == lhs.isHistory
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(id)
    }
}

extension Task {
    static let defaultRepetition = [false, false, false, false, false, false, false]

    enum Field: String {
        case name, proof
    }
}

enum TaskStatus: String, Codable, CaseIterable {
    case todayList = "Today List"
    case waitingEmployeeReview = "Waiting Employee Review"
    case waitingOwnerReview = "Waiting Owner Review"
    case revise = "Revise"
    case completed = "Completed"

    var title: String {
        switch self {
        case .todayList:
            return "Today List"
        case .waitingEmployeeReview:
            return RoleService.shared.isOwner ? "Waiting Employee Review" : "Waiting Peer Review"
        case .waitingOwnerReview:
            return "Waiting Owner Review"
        case .revise:
            return "Revise"
        case .completed:
            return "Completed"
        }
    }
}
