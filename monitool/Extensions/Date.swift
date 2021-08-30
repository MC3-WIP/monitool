//
//  Date.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 26/08/21.
//

import Foundation

extension Date {
    func dayNumberOfWeek(day: String) -> Int {
        switch day {
        case "Sunday":
            return 0
        case "Monday":
            return 1
        case "Tuesday":
            return 2
        case "Wednesday":
            return 3
        case "Thursday":
            return 4
        case "Friday":
            return 5
        case "Saturday":
            return 6
        default:
            return 99
        }
    }
}
