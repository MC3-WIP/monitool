//
//  MainViewModel.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import SwiftUI

class MainViewModel: ObservableObject {
	private var device = UIDevice.current.userInterfaceIdiom

	@ViewBuilder
	func Layout() -> some View {
		if device == .pad {
			PadMainView()
		} else if device == .phone {
			PhoneMainView()
		}
	}
}
