//
//  Company.swift
//  monitool
//
//  Created by Mac-albert on 28/07/21.
//

import FirebaseFirestore
import Combine
import FirebaseAuth

final class CompanyRepository: ObservableObject{
    @Published var companies = [Company]()
    private let paths = RepositoriesPath()
    private let store = Firestore.firestore()
	var companyRef: DocumentReference?

	static let shared = CompanyRepository()

    private init() {
        if let user = Auth.auth().currentUser{
            companyRef = store.collection(paths.company).document(user.uid)
        }
    }
    
    func add(_ company: Company){
        companyRef?.setData(["name": company.name, "minReview": company.minReview, "profileImage": "profile", "ownerPin": company.ownerPin])
    }
    
    func addImage(imageURL: String) {
        companyRef?.updateData(["profileImage": imageURL])
    }
    
    func delete(_ company: Company) {
        store.collection(paths.company).document(company.id).delete()
    }
    
    func editCompanyName(name: String){
        companyRef?.updateData(["name": name])
    }
    
    func editCompanyMinReview(minReview: Int){
        companyRef?.updateData(["minReview": minReview])
    }
    
    // MARK: EDIT PHOTO BELOM
    
    func approveTask(status: String){
        
    }
    
    func rejectTask(status: String){
        
    }
}
