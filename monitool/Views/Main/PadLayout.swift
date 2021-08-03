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
			ZStack {
				Color.AppColor.secondary.edgesIgnoringSafeArea(.all)
				SidebarView()
					.environmentObject(viewModel)
			}
			DetailView()
		}
		.accentColor(.AppColor.primary)
	}
}

// MARK: - View Builders
extension PadLayout {
	@ViewBuilder
	func DetailView() -> some View {
		switch viewModel.currentDetailViewType {
		case .todayList, .peerReview, .ownerReview, .revise, .taskManager:
			TaskListView(filter: $viewModel.currentTaskFilter)
		case .history:
			HistoryView()
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
