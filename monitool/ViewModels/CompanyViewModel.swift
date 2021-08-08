//
//  CompanyViewModel.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 02/08/21.
//

import Combine
import SwiftUI

class CompanyViewModel: ObservableObject {
    @ObservedObject private var repository = CompanyRepository()

    func create(_ company: Company){
        repository.add(company)
    }
    
    func addImage(imageURL: String) {
        repository.addImage(imageURL: imageURL)
    }
}
