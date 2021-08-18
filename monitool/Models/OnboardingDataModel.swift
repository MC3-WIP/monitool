//
//  OnboardingDataModel.swift
//  monitool
//
//  Created by Mac-albert on 11/08/21.
//

import Foundation

struct OnboardingDataModel {
    var image: String
    var titleText: String
    var descText: String
}

extension OnboardingDataModel {
	static var dataOnboarding: [OnboardingDataModel] = [
		OnboardingDataModel(image: "MonitoolLogo", titleText: "Monitool", descText: "Level Up Your Business"),
		OnboardingDataModel(
			image: "Assignillustration",
			titleText: "Assign",
			descText: "Assign tasks to make sure your business keep running"
		),
		OnboardingDataModel(
			image: "MonitorIllustration",
			titleText: "Monitor",
			descText: "Monitor your employee works result with ease"
		),
		OnboardingDataModel(
			image: "ReviewIllustration",
			titleText: "Review",
			descText: "You can review and let your employee validates their peer works result on site"
		)
	]
}
