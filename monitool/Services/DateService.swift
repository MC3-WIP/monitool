//
//  DateService.swift
//  monitool
//
//  Created by Devin Winardi on 25/08/21.
//

import Foundation

class DateService: ObservableObject {
    static let shared = DateService()
    let date = Date()
    let dateFormatter = DateFormatter()
    
    func getCurrentDay() -> String {
        dateFormatter.dateFormat = "EEEE"
        let currentDay = dateFormatter.string(from: date)
        UserDefaults.standard.set(currentDay, forKey: "currentDay")
        return currentDay
    }
    
    func isDayChanged() -> Bool {
        let dayDefault = UserDefaults.standard.string(forKey: "currentDay")
        let newDay = getCurrentDay()
        if dayDefault == newDay {
            return false
        } else {
            UserDefaults.standard.set(newDay, forKey: "currentDay")
            return true
        }
    }
}
