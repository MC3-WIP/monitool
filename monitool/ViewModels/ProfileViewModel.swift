//
//  ProfileViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 05/08/21.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Foundation

class ProfileViewModel: ObservableObject {
    @Published var company: Company

    // UI State
    @Published var isPinHidden = true
    @Published var isPinPresenting = false
    @Published var isAddEmployeePresenting = false

    @Published var pinInputted = ""
    @Published var isPasscodeFieldDisabled = false
    static let shared = ProfileViewModel()

    private let companyRepository: CompanyRepository = .shared

    init() {
        company = Company(name: "", minReview: 0, ownerPin: "", hasLoggedIn: true, profileImage: "")
        getCompany()
    }

    var reviewerString: String {
        "\(company.minReview) Reviewer\(company.minReview > 1 ? "s" : "")"
    }

    func updateCompany(companyName: String, companyPIN: String, minReview: Int) {
        companyRepository.editCompanyName(name: companyName)
        companyRepository.editCompanyPIN(ownerPIN: companyPIN)
        companyRepository.editCompanyMinReview(minReview: minReview)
    }

    func getCompany() {
        if let ref = companyRepository.companyRef {
            ref.getDocument { doc, err in
                if let err = err { fatalError("Unresolved error: \(err)") }

                if let doc = doc, doc.exists {
                    do {
                        if let company = try doc.data(as: Company.self) {
                            self.company = company
                        }
                    } catch {
                        print("Error parsing company data:", error.localizedDescription)
                    }
                }
            }
        }
    }
}
