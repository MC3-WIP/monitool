//
//  MainView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct MainView: View {
	private var device = UIDevice.current.userInterfaceIdiom

	var body: some View {
		Layout()
    }
}

// MARK: - View Builders
extension MainView {
	@ViewBuilder
	func Layout() -> some View {
		if device == .pad {
			PadLayout()
		} else if device == .phone {
			CompanyOnboarding()
		} else {
			Text("Monitool's only available for iPhone and iPad, so how'd u get here?")
		}
	}
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
