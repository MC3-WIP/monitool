//
//  TabItemRow.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI

struct TaskNotification {
	var isPriority: Bool
	var count: Int
}

struct TabItemRow: View {
	var notification: TaskNotification? = nil
	@Binding var selection: String
	let title: String
	let icon: String
	var isActive: Bool {
		selection == title
	}
	var onTap: ((Self) -> Void)? = nil

    var body: some View {
		HStack {
			Image(systemName: icon)
				.foregroundColor(isActive ? AppColor.primaryForeground : AppColor.accent)
			Text(title)
				.foregroundColor(isActive ? AppColor.primaryForeground : AppColor.secondary)
			Spacer()
			if let notification = notification, notification.count > 0 {
				Text("\(notification.count)")
					.foregroundColor(notification.isPriority || isActive ? AppColor.primaryForeground : AppColor.secondary)
					.frame(width: 24, height: 24, alignment: .center)
					.background(notification.isPriority ? Color.red : Color.clear)
					.clipShape(Circle())
			}
		}
		.padding(12)
		.background(isActive ?  AppColor.accent : Color.clear)
		.cornerRadius(12)
		.contentShape(Rectangle())
		.onTapGesture {
			onTap?(self)
		}
    }
}

struct TabItemRow_Previews: PreviewProvider {
    static var previews: some View {
		TabItemRow(
			notification: TaskNotification(isPriority: true, count: 4),
			selection: .constant(TaskStatus.todayList.rawValue),
			title: "Task List",
			icon: "list.number"
		)
    }
}
