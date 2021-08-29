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
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
    }
    
    func getStringFromDate(date: Date) -> String {
        dateFormatter.string(from: date)
    }
}
