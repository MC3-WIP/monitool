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
    @Binding var isPresented: Bool

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
            }
            .navigationBarTitle("Repeat List", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    isPresented = false
                }
            ).foregroundColor(AppColor.accent)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
