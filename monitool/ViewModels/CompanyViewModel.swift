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
    @Published var companies = [Company]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        repository.$companies
            .assign(to: \.companies, on: self)
            .store(in: &cancellables)
    }

    func add(_ company: Company){
        repository.add(company)
    }

    func delete(_ offsets: IndexSet) {
        offsets.forEach { index in
            repository.delete(companies[index])
        }
    }
}
