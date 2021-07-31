//
//  MainView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct MainView: View {
	var device = UIDevice.current.userInterfaceIdiom

    var body: some View {
		Main()
    }

	@ViewBuilder
	func Main() -> some View {
		if device == .pad {
			PadMainView()
		} else if device == .phone {
			PhoneMainView()
		}
	}
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
