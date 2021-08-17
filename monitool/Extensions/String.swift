//
//  String.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 17/08/21.
//

import SwiftUI

extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }
    
}
