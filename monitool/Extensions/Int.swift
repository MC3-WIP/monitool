//
//  Int.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 17/08/21.
//

import SwiftUI

extension Int {

    var numberString: String {

        guard self < 10 else { return "0" }

        return String(self)
    }
}
