//
//  DateService.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 26/08/21.
//

import Foundation

class DateService: ObservableObject {

    static let shared = DateService()
    let date = Date()
    let dateFormatter = DateFormatter()

    func getCurrentDay() -> Int {
        dateFormatter.dateFormat = "EEEE"
        let currentDay = dateFormatter.string(from: date)
        let currentDayNumber = date.dayNumberOfWeek(day: currentDay) + 1
        UserDefaults.standard.set(currentDayNumber, forKey: "currentDay")
        return currentDayNumber
    }

    func isDayChanged() -> Bool {
        let dayDefault = UserDefaults.standard.integer(forKey: "currentDay")
        let newDay = getCurrentDay()
        if dayDefault == newDay {
            return false
        } else {
            UserDefaults.standard.set(newDay, forKey: "currentDay")
            return true
        }
    }
}
