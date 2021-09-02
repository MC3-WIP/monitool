//
//  HistoryRow.swift
//  monitool
//
//  Created by Christianto Budisaputra on 16/08/21.
//

import SwiftUI
import UIKit

class HistoryRowModel: ObservableObject {
	@Published var taskTitle: String
	@Published var picName = "-"

	init(task: Task) {
		taskTitle = task.name
		task.pic?.getDocument { [self] doc, err in
			if let err = err {
				print("Error occured while getting PIC data.", err.localizedDescription)
				return
			}

			guard let doc = doc else { return }

			do {
				if let pic = try doc.data(as: Employee.self) {
					picName = pic.name
				}
			} catch {
				print("Unable to parse employee name")
			}
		}
	}
}

struct HistoryRow: View {
    @StateObject var viewModel: HistoryRowModel

    init(task: Task) {
        _viewModel = StateObject(wrappedValue: HistoryRowModel(task: task))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
			Text(viewModel.taskTitle)
			Text("PIC: \(viewModel.picName)")
                .font(.caption)
                .foregroundColor(Color("DarkGray"))
        }.listRowBackground(Color("LightTosca"))
    }
}
