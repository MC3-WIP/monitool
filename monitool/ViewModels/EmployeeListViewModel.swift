//
//  EmployeeListViewModel.swift
//  monitool
//
//  Created by Devin Winardi on 29/07/21.
//

import Combine
import SwiftUI

class EmployeeListViewModel: ObservableObject {
	@ObservedObject private var repository: EmployeeRepository = .shared
    @Published var employees = [Employee]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        repository.$employees
            .assign(to: \.employees, on: self)
            .store(in: &cancellables)
    }

    func add(_ employee: Employee){
        repository.add(employee)
    }

    func delete(_ offsets: IndexSet) {
        offsets.forEach { index in
            repository.delete(employees[index])
        }
    }
}
