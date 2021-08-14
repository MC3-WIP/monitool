//
//  TodayListView+ViewBuilders.swift
//  monitool
//
//  Created by Christianto Budisaputra on 07/08/21.
//

import SwiftUI

// MARK: - View Builders
extension TodayListView {
	@ViewBuilder func LeftColumn() -> some View {
		GeometryReader { metric in
			VStack {
				//			ScrollView {
				Text(todayListViewModel.task.name)
					.font(.system(size: 28, weight: .bold))
					.frame(minWidth: 100, maxWidth: .infinity, minHeight: 28, maxHeight: 32, alignment: .leading)
                Image("kucing1")
					.resizable()
					.frame(width: metric.size.width * 0.8, height: metric.size.width * 0.8, alignment: .leading)
				if let desc = todayListViewModel.task.desc {
					Text(desc)
                        .frame(width: metric.size.width * 0.8, alignment: .topLeading)
						.font(.system(size: 17))
						.multilineTextAlignment(.leading)
				}
			}
		}
	}

	@ViewBuilder func RightColumn() -> some View {
		GeometryReader { matric in
			//			VStack(spacing: 24) {
			ScrollView {
				Text("Proof of Work")
					.padding(.bottom, 8)
					.font(.system(size: 20, weight: .bold))
					.frame(minWidth: 100, maxWidth: .infinity, minHeight: 20, maxHeight: 24, alignment: .leading)
					.foregroundColor(Color(hex: "898989"))
                
				ProofOfWork(image: "kucing2", date: "p", metricSize: matric)
					.frame(width: matric.size.width * 0.75, height: matric.size.width * 0.75)
					.padding(.vertical, 10)
					.background(Color(hex: "F0F9F8"))
					.overlay(
						RoundedRectangle(cornerRadius: 5)
							.stroke(Color(hex: "4EB0AB"), lineWidth: 1)
					)
				
                if role.isOwner {
					CustomText(title: "PIC: ", content: todayListViewModel.pic?.name)
					CustomText(title: "Notes: ", content: todayListViewModel.task.notes)
				} else {
					PICSelector()
					NotesTextField()
				}
			}
		}
	}

	@ViewBuilder func EmployeePicker() -> some View {
		VStack(spacing: -36) {
			HStack {
				Button("Cancle") {
					todayListViewModel.isEmployeePickerPresenting = false
				}.foregroundColor(AppColor.accent)
				Spacer()
				Text("PIC")
				Spacer()
				Button {
					todayListViewModel.isEmployeePickerPresenting = false
				} label: {
					Text("Done").bold()
				}.foregroundColor(AppColor.accent)
			}
			.padding()
			.zIndex(1)

			Picker("PIC", selection: $todayListViewModel.picSelection) {
				ForEach(0..<employeeRepository.employees.count) { index in
					Text(employeeRepository.employees[index].name).tag(index)
				}
			}
		}
	}

	@ViewBuilder func PICSelector() -> some View {
		VStack(alignment: .leading) {
			Text("PIC")
				.font(.title2)
				.foregroundColor(.secondary)
				.bold()
			HStack {
				Text(employeeRepository.employees[todayListViewModel.picSelection].name)
				Spacer()
				Button {
					todayListViewModel.isEmployeePickerPresenting = true
				} label: {
					Image(systemName: "chevron.down")
				}
				.foregroundColor(.secondary)
				.popover(isPresented: $todayListViewModel.isEmployeePickerPresenting) {
					EmployeePicker()
				}
			}
			.padding()
			.background(AppColor.accent.brightness(0.65))
			.modifier(RoundedEdge(width: 2, color: AppColor.accent, cornerRadius: 8))
		}
	}

	@ViewBuilder func NotesTextField() -> some View {
		VStack(alignment: .leading) {
			Text("Notes")
				.font(.title2)
				.foregroundColor(.secondary)
				.bold()
			TextField("Add notes here", text: $todayListViewModel.notesText)
				.padding()
				.frame(height: 120, alignment: .top)
				.background(Color(hex: "F0F9F8"))
				.modifier(RoundedEdge(width: 2, color: AppColor.accent, cornerRadius: 8))
		}
	}

	@ViewBuilder func CustomText(title: String, content: String?) -> some View {
		HStack{
			Text(title)
				.foregroundColor(Color(hex: "6C6C6C"))
				.font(.system(size: 17, weight: .bold))
			Text(content ?? "-")
		}.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
	}

	@ViewBuilder func ProofOfWork(image: String, date: String, metricSize: GeometryProxy) -> some View{
		VStack{
			Image(image)
				.resizable()
				.frame(width: metricSize.size.width * 0.5, height: metricSize.size.width * 0.5)
			//            Text("21 Jul 2021 at 15:57")
			//                .font(.system(size: 11))
			//                .frame(width: metricSize.size.width * 0.7, height: 12, alignment: .leading)
		}
	}
}
