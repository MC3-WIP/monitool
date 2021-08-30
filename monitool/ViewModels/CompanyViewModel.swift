//
//  CompanyViewModel.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 02/08/21.
//

import Combine
import SwiftUI

final class CompanyViewModel: ObservableObject {
    private let repository: CompanyRepository = .shared

	static let shared = CompanyViewModel()

	private init() {}

    func create(_ company: Company) {
        repository.add(company)
    }

    func addImage(imageURL: String) {
        repository.addImage(imageURL: imageURL)
    }
}
