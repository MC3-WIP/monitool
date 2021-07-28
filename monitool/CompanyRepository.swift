//
//  Company.swift
//  monitool
//
//  Created by Mac-albert on 28/07/21.
//

import Foundation
import Firebase

class CompanyRepository: ObservableObject{
    private let path: String = "Companies"
    private let store = Firestore.firestore()
    private let id: String = "id"
    
    func addTask(task: Task, name: String, description: String) -> Self {
        task.name = name
        task.desc = description
        
        // MARK: Unfinished
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
    
    func addEmployee(name: String){
        // MARK: Unfinished
//        store.collection(path).document().setData()
        let newEmployee = Employee(name: name)
    }
    
    func deleteEmployee(employee: Employee, name: String){
        store.collection(path).document(id).delete { error in
            if let error = error {
                print("Unable to remove card: \(error.localizedDescription)")
            }  else {
                print("Successfully deleted  story text")
            }
        }
    }
    
    func editCompanyName(company: Company, name: String){
        company.name = name
        // MARK: Unfinished
//        store.collection(path).document().setData()
//        return self
    }
    
    func approveTask(status: String){
        
    }
    
    func rejectTask(status: String){
        
    }
}
