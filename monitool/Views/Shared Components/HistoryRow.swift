//
//  HistoryRow.swift
//  monitool
//
//  Created by Christianto Budisaputra on 16/08/21.
//

import SwiftUI

struct HistoryRow: View {
    @StateObject var taskDetailViewModel: TaskDetailViewModel
    
    init (task: Task){
        _taskDetailViewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
    }

	var body: some View {
		VStack(alignment: .leading) {
            Text(taskDetailViewModel.task.name)
            Text("PIC: \(taskDetailViewModel.pic?.name ?? "-")")
				.font(.caption)
				.foregroundColor(Color(hex: "#7A7A7A"))
		}.listRowBackground(Color(hex: "#F0F9F8"))
	}
}
