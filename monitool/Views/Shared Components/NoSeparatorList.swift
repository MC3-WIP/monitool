//
//  NoSeparatorList.swift
//  monitool
//
//  Created by Mac-albert on 04/08/21.
//

import SwiftUI
import UIKit

struct NoSeparatorList<Content>: View where Content: View {

    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content

    }

    var body: some View {
        if #available(iOS 14.0, *) {
           ScrollView {
               LazyVStack(spacing: 10) {
                self.content()
             }
           }
        } else {
            List {
                self.content()
            }
            .onAppear {
               UITableView.appearance().separatorStyle = .none
            }.onDisappear {
               UITableView.appearance().separatorStyle = .singleLine
            }
        }
    }
}
