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
		layout()
    }
}

// MARK: - View Builders
extension MainView {
	@ViewBuilder
	func layout() -> some View {
		if device == .pad {
			PadLayout()
		} else if device == .phone {
			PhoneLayout()
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
