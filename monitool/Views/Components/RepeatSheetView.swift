//
//  RepeatSheetView.swift
//  monitool
//
//  Created by Scaltiel Gloria on 06/08/21.
//

import SwiftUI

struct RepeatSheetView: View {
    @State var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    @State var daysSimplified = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @Binding var repeated: [Bool]
    @Binding var selectedDays: [String]
    var body: some View {
        NavigationView {
            VStack {
                List(0..<days.count) { i in
                    Button(action: {
                        if repeated[i] {
                            repeated[i] = !repeated[i]
                            selectedDays.removeAll(where: {$0 == daysSimplified[i]})
                        } else {
                            repeated[i] = !repeated[i]
                            selectedDays.append(daysSimplified[i])
                        }
                    }) {
                        HStack() {
                            Text("Every \(days[i])").foregroundColor(Color.black)
                            Spacer()
                            if repeated[i] {
                                Image(systemName: "checkmark").foregroundColor(AppColor.accent)
                            }
                        }
                        
                    }
                }
            }.navigationTitle("Task List").navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct RepeatSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        RepeatSheetView(repeated: )
//    }
//}
