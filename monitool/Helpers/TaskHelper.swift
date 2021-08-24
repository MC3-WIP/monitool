//
//  TaskHelper.swift
//  monitool
//
//  Created by Christianto Budisaputra on 18/08/21.
//

import Foundation

struct TaskHelper {
    static func convertRepetition(_ repetition: [Bool], simplified: Bool = false) -> String {
        if repetition.filter({ $0 == true }).count == 7 { return "Everyday" }

        let days = [
            "Sunday", "Monday", "Tuesday",
            "Wednesday", "Thursday", "Friday", "Saturday",
        ]

        let simplifiedDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

        var filteredDays = [String]()

        repetition.enumerated().forEach { index, isOn in
            if isOn {
                if simplified {
                    filteredDays.append(simplifiedDays[index])
                } else {
                    filteredDays.append(days[index])
                }
            }
        }

        return filteredDays.joined(separator: ", ")
    }
}
