//
//  PadMenu.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct PadLayout: View {
	@StateObject private var viewModel: PadLayoutViewModel

	init(detailView: SidebarViewModel.MenuItem? = nil) {
		_viewModel = StateObject(wrappedValue: PadLayoutViewModel(detailView: detailView))
	}

	var body: some View {
		NavigationView {
			ZStack {
				Color.AppColor.secondary.edgesIgnoringSafeArea(.all)
				SidebarView()
					.environmentObject(viewModel)
			}
			LayoutDetailView()
		}
		.accentColor(.AppColor.primary)
	}
}

// MARK: - View Builders
extension PadLayout {
	@ViewBuilder
	func LayoutDetailView() -> some View {
		switch viewModel.currentDetailViewType {
		case .todayList, .peerReview, .ownerReview, .revise, .taskList:
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
