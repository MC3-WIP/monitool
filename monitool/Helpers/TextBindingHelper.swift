//
//  TextBindingHelper.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 11/08/21.
//

import Foundation

class TextBindingHelper: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 4) {
        characterLimit = limit
    }
}
