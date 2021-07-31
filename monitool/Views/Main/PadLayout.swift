//
//  PadMenu.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct PadLayout: View {
	@StateObject private var viewModel = PadLayoutViewModel()

	var body: some View {
		NavigationView {
			SidebarView(
				taskFilter: $viewModel.currentTaskFilter,
				currentDetailViewType: $viewModel.currentDetailViewType
			)
			DetailView()
		}
	}
}

// MARK: - View Builders
extension PadLayout {
	@ViewBuilder
	func DetailView() -> some View {
		switch viewModel.currentDetailViewType {
		case .filteredTaskList:
			TaskListView(filter: $viewModel.currentTaskFilter)
		case .ownerTaskList:
			TaskListAdminView()
		case .profile:
			ProfileView()
		}
	}
}

struct PadMenu_Previews: PreviewProvider {
	static var previews: some View {
		PadLayout()
	}
}
