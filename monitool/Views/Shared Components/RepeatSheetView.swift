//
//  RepeatSheetView.swift
//  monitool
//
//  Created by Scaltiel Gloria on 06/08/21.
//

import SwiftUI

struct RepeatSheetView: View {
    @State var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

	@Binding var repeated: [Bool]

    var body: some View {
        NavigationView {
            VStack {
                List(0..<7) { index in
                    Button {
						repeated[index].toggle()
					} label: {
                        HStack {
							Text("Every \(days[index])").foregroundColor(AppColor.primaryBackground)
                            Spacer()
                            if repeated[index] {
                                Image(systemName: "checkmark").foregroundColor(AppColor.accent)
                            }
                        }
                    }
                }
            }.navigationBarTitle("Task List", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

// struct RepeatSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        RepeatSheetView(repeated: )
//    }
// }
