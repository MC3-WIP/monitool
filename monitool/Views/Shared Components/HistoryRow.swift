//
//  HistoryRow.swift
//  monitool
//
//  Created by Christianto Budisaputra on 16/08/21.
//

import SwiftUI

struct HistoryRow: View {
	var task: Task

	var body: some View {
		VStack(alignment: .leading) {
			Text(task.name)
			Text("PIC: \(task.pic!)")
				.font(.caption)
				.foregroundColor(Color(hex: "#7A7A7A"))
		}.listRowBackground(Color(hex: "#F0F9F8"))
	}
}
