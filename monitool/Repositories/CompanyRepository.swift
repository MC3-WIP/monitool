//
//  Company.swift
//  monitool
//
//  Created by Mac-albert on 28/07/21.
//

import Combine
import FirebaseAuth
import FirebaseFirestore

final class CompanyRepository: ObservableObject {
    private let paths = RepositoriesPath()
    private let store = Firestore.firestore()
    var companyRef: DocumentReference?

    static let shared = CompanyRepository()

    @Published var company: Company?

    private init() {
        if let user = Auth.auth().currentUser {
            companyRef = store.collection(paths.company).document(user.uid)
        }

        companyRef?.addSnapshotListener { snapshot, _ in
            do {
                self.company = try snapshot?.data(as: Company.self)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func add(_ company: Company) {
        companyRef?.setData([
            "name": company.name,
            "minReview": company.minReview,
            "profileImage": "profile",
            "ownerPin": company.ownerPin
        ])
    }

    func updateProfileImage(url: String, completion: ((Error?) -> Void)? = nil) {
        companyRef?.updateData(["profileImage": url], completion: completion)
    }

    func delete(_ company: Company) {
        store.collection(paths.company).document(company.id).delete()
    }

    func editCompanyName(name: String) {
        companyRef?.updateData(["name": name])
    }

    func editCompanyMinReview(minReview: Int) {
        companyRef?.updateData(["minReview": minReview])
    }

    func editCompanyPIN(ownerPIN: String) {
        companyRef?.updateData(["ownerPin": ownerPIN])
    }
}
