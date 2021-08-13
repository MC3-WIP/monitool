//
//  ProfileViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 05/08/21.
//

import FirebaseFirestore
import Foundation
import FirebaseAuth

class ProfileViewModel: ObservableObject {
	
	@Published var employees = [Employee]()

    
	// UI State
	@Published var isPinHidden = true
	@Published var isPinPresenting = false
	@Published var isAddEmployeePresenting = false

    private let companyRepository: CompanyRepository = .shared
    
    var company: Company
    
    init() {
        company = Company(name: "Devin Test", minReview: 2, ownerPin: "1234", hasLoggedIn: true)
        getCompany()
    }

	func delete(_ offsets: IndexSet) {
		offsets.forEach { index in
			employees.remove(at: index)
		}
	}

	var reviewerString: String {
        "\(company.minReview) Reviewer\(company.minReview > 1 ? "s" : "")"
	}

	func incrementReviewer() {
        company.minReview += 1
        if company.minReview > employees.count { company.minReview = employees.count }
	}

	func decrementReviewer() {
        company.minReview -= 1
        if company.minReview < 0 { company.minReview = 0 }
	}
    
    func getCompany() {
        if let ref = companyRepository.companyRef {
            ref.getDocument(completion: { doc, err in
                if let err = err {
                    fatalError("Unresolved error: \(err)")
                }

                if let doc = doc, doc.exists {
                    do {
//                        self.company = try doc.data(as: Company.self) ?? Company(name: "Devin Test", minReview: 2, ownerPin: "1234", hasLoggedIn: true)
                        self.company = Company(name: doc.get("name") as! String, minReview: doc.get("minReview") as! Int, ownerPin: doc.get("ownerPin") as! String, hasLoggedIn: true)
                    } catch {
                        print("Unresolved error: \(error.localizedDescription)")
                    }
                }
            })
        }
    }
    
    func fetchCompany(){
        guard let userID = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("companies").document(userID).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                print("document id sini", userID)
                print("disini", document.get("name") as Any)
//                let fieldValue = document.get("myFieldName") as? Int
//                let fieldValueType2 = document.data()?["myFieldName"] as? Int
            } else {
                print("Document does not exist")
            }
        }
    }
}

// qXsHg1SBWwTkD3cXvO7SJ3JSAOD2
