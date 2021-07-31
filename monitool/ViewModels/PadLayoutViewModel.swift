//
//  PadLayoutViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import Foundation

class PadLayoutViewModel: ObservableObject {
	@Published var currentTaskFilter: TaskStatus = .ongoing
	@Published var currentDetailViewType: DetailViewType = .filteredTaskList
}

extension PadLayoutViewModel {
	enum DetailViewType {
		case filteredTaskList, ownerTaskList, profile
	}
}
