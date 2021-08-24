//
//  UIApplication.swift
//  monitool
//
//  Created by Christianto Budisaputra on 25/08/21.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
