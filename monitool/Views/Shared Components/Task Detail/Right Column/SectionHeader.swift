//
//  SectionHeader.swift
//  monitool
//
//  Created by Christianto Budisaputra on 26/08/21.
//

import SwiftUI

struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title).foregroundColor(.gray).font(.title3).bold()
    }
}
