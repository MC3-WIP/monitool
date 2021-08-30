//
//  HistoryTaskDetailView.swift
//  monitool
//
//  Created by Mac-albert on 07/08/21.
//

import SDWebImageSwiftUI
import SwiftUI

class HistoryViewModel: TaskDetailViewModel {
}

struct HistoryTaskDetailView: View {
    @StateObject var historyViewModel: HistoryViewModel

	@ObservedObject var role: RoleService = .shared

    init(task: Task) {
        _historyViewModel = StateObject(wrappedValue: HistoryViewModel(task: task))
    }

    var body: some View {
		VStack {
			ScrollView {
				HStack(alignment: .top, spacing: 24) {
					renderLeftColumn()

					VStack(alignment: .leading, spacing: 24) {
						ProofOfWork(task: historyViewModel.task)

						RightColumn<HistoryViewModel>(
							components: role.isOwner ? [
								.picText,
								.notesText,
								.commentText,
								.logs
							] : [
								.picText,
								.notesText,
								.commentText
							],
							viewModel: historyViewModel
						)
					}
                }
                .padding([.top, .leading, .trailing], 24.0)
			}
        }
    }

	@ViewBuilder func renderLeftColumn() -> some View {
		VStack(alignment: .leading) {
			// Task Title
			Text(historyViewModel.title).font(.title.bold())

			// Reference Image
			if let image = historyViewModel.photoReference {
				WebImage(url: URL(string: image))
					.resizable()
					.indicator { _, _ in
						ProgressView()
					}
					.scaledToFit()
			} else {
				Image("EmptyReference")
					.resizable()
					.scaledToFill()
					.padding([.horizontal, .bottom], 36)
			}

			Text(historyViewModel.desc)
		}
	}
}
