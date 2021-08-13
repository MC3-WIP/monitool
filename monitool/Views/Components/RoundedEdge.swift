//
//  RoundedEdge.swift
//  monitool
//
//  Created by Christianto Budisaputra on 07/08/21.
//

import SwiftUI

struct RoundedEdge: ViewModifier {
	let width: CGFloat
	let color: Color
	let cornerRadius: CGFloat

	func body(content: Content) -> some View {
		content.cornerRadius(cornerRadius - width)
			.padding(width)
			.background(color)
			.cornerRadius(cornerRadius)
	}
}
