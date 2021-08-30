//
//  TextLimitter.swift
//  monitool
//
//  Created by Mac-albert on 26/08/21.
//

import Foundation

class TextLimiter: ObservableObject {
    private let limit: Int

    init(limit: Int) {
        self.limit = limit
    }

    @Published var value = "" {
        didSet {
            if value.count > self.limit {
                value = String(value.prefix(self.limit))
                self.hasReachedLimit = true
            } else {
                self.hasReachedLimit = false
            }
        }
    }
    @Published var hasReachedLimit = false
}
