//
//  ButtonStyle.swift
//  monitool
//
//  Created by Christianto Budisaputra on 07/08/21.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.frame(minWidth: 0, maxWidth: .infinity)
			.padding(.vertical, 18)
			.foregroundColor(AppColor.primaryForeground)
			.font(.title3)
			.background(AppColor.accent)
			.cornerRadius(12)
	}
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
		Button("Click Me!") {

		}.buttonStyle(PrimaryButtonStyle())
    }
}
