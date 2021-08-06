//
//  RepeatSheetView.swift
//  monitool
//
//  Created by Scaltiel Gloria on 06/08/21.
//

import SwiftUI

struct RepeatSheetView: View {
    @State var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    var body: some View {
        NavigationView {
            VStack {
                List(days, id: \.self) { day in
                    Button(action: {
                        print("Button clicked")
                    }) {
                        Text("Every \(day)")
                    }
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
