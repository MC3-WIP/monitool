//
//  RepeatSheetView.swift
//  monitool
//
//  Created by Scaltiel Gloria on 06/08/21.
//

import SwiftUI

struct RepeatSheetView: View {
    @State var days = ["Every Sunday","Every Monday","Every Tuesday","Every Wednesday","Every Thursday","Every Friday","Every Saturday"]
    var body: some View {
        NavigationView {
            VStack {
                List(days, id: \.self) { day in
                    Text(day)
                }
            }.navigationTitle("Task List").navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RepeatSheetView_Previews: PreviewProvider {
    static var previews: some View {
        RepeatSheetView()
    }
}
