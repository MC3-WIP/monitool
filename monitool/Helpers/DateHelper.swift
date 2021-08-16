//
//  DateHelper.swift
//  monitool
//
//  Created by Christianto Budisaputra on 16/08/21.
//

import Foundation

struct DateHelper {
	private let dateFormatter: DateFormatter

	init() {
		dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd-MM-YY"
	}

	func getNumDays(first: Date, second: Date) -> Int {
		let calendar = Calendar.current

		// Replace the hour (time) of both dates with 00:00
		let date1 = calendar.startOfDay(for: first)
		let date2 = calendar.startOfDay(for: second)

		let components = calendar.dateComponents([.day], from: date1, to: date2)

		return components.day ?? 0
	}

	func getStringFromDate(date: Date) -> String {
		dateFormatter.string(from: date)
	}
}
