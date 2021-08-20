//
//  Alert.swift
//  monitool
//
//  Created by Christianto Budisaputra on 19/08/21.
//

import SwiftUI

extension AppAlert {
	struct TaskList {
		static let failUploading = Alert(
			title: Text("Alert"),
			message: Text("It seems like we're currently unable to upload your reference image, please wait and try again."),
			dismissButton: .default(Text("Got it!"))
		)
	}
}
