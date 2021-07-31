//
//  MainView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct MainView: View {
	@StateObject private var viewModel = MainViewModel()

	var body: some View {
		viewModel.Layout()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
