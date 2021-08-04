//
//  Company.swift
//  monitool
//
//  Created by Mac-albert on 28/07/21.
//

import FirebaseFirestore
import Combine
import FirebaseAuth

class CompanyRepository: ObservableObject{
    @Published var companies = [Company]()
    private let paths = RepositoriesPath()
    private let store = Firestore.firestore()
    private var companyRepositories: DocumentReference? = nil
    
    init() {
//        if let user = Auth.auth().currentUser{
//            companyRepositories = store.collection(paths.company).document(user.uid)
//        }
        companyRepositories = store.collection(paths.company).document("w7zd8Hi13yaQEJdVea79105p5aU2")
    }
    
    func add(_ company: Company){
        companyRepositories?.setData(["name": company.name, "minReview": company.minReview])
    }
    
    func delete(_ company: Company) {
        store.collection(paths.company).document(company.id).delete()
        //        store.collection(path).document(id).delete { error in
        //            if let error = error {
        //                print("Unable to remove card: \(error.localizedDescription)")
        //            }  else {
        //                print("Successfully deleted  story text")
        //            }
        //        }
    }
    
    func editCompanyName(name: String){
        companyRepositories?.updateData(["name": name])
    }
    
    func editCompanyMinReview(minReview: Int){
        companyRepositories?.updateData(["minReview": minReview])
    }
    
    // MARK: EDIT PHOTO BELOM
    
    func approveTask(status: String){
        
    }
    
    func rejectTask(status: String){
        
    }
}
