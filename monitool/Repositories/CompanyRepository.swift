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
//    @Published var company: Company
    private let paths = RepositoriesPath()
    private let store = Firestore.firestore()
    private var companyRepositories: DocumentReference? = nil
    
    init() {
        if let user = Auth.auth().currentUser{
            companyRepositories = store.collection(paths.company).document(user.uid)
        }
        
    }
    
    func addTask(task: Task, name: String, description: String) -> Self {
//        task.name = name
//        task.desc = description
        
        // MARK: Unfinished again
//        store.collection(path).document(id).setData()
        return self
    }
    
    func deleteTask(task: Task, name: String) {
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
