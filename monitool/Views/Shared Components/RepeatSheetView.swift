//
//  RepeatSheetView.swift
//  monitool
//
//  Created by Scaltiel Gloria on 06/08/21.
//

import SwiftUI

struct RepeatSheetView: View {
    @State var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @State var daysSimplified = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @Binding var repeated: [Bool]
    @Binding var selectedDays: [String]
    var body: some View {
        NavigationView {
            VStack {
                List(0..<days.count) { index in
                    Button {
                        if repeated[index] {
                            repeated[index] = !repeated[index]
                            selectedDays.removeAll(where: {$0 == daysSimplified[index]})
                        } else {
                            repeated[index] = !repeated[index]
                            selectedDays.append(daysSimplified[index])
                        }
					} label: {
                        HStack {
                            Text("Every \(days[index])").foregroundColor(Color.black)
                            Spacer()
                            if repeated[index] {
                                Image(systemName: "checkmark").foregroundColor(AppColor.accent)
                            }
                        }

                    }
                }
            }.navigationTitle("Task List").navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

// struct RepeatSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        RepeatSheetView(repeated: )
//    }
// }
