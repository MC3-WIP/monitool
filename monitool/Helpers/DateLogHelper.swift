//
//  DateLogHelper.swift
//  monitool
//
//  Created by Mac-albert on 29/08/21.
//

import Foundation

struct DateLogHelper {
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
    }
    
    func getStringFromDate(date: Date) -> String {
        dateFormatter.string(from: date)
    }
}
