//
//  EmployeeHelper.swift
//  monitool
//
//  Created by Christianto Budisaputra on 27/07/21.
//

extension Employee {
    enum Helper {
        static func generatePIN() -> String {
            let pin = Int.random(in: 0 ..< 10000)
            return String(pin).padding(toLength: 4, withPad: "0", startingAt: 0)
        }
    }
}
