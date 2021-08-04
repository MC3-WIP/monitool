//
//  ProfileView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import SwiftUI

struct ProfileView: View {
	@State var isPinHidden = true
	@State var editMode: EditMode = .inactive {
		didSet {
			if editMode.isEditing { isPinHidden = false }
			else { isPinHidden = true }
		}
	}
	@State var companyName = "Kopi Kulo"
	@State var ownerPin = ""
	@State var minReviewer = 0

	@State var employees = [
		Employee(name: "Alpha"),
		Employee(name: "Bravo"),
		Employee(name: "Charlie"),
		Employee(name: "Delta"),
		Employee(name: "Echo"),
		Employee(name: "Alpha"),
		Employee(name: "Bravo"),
		Employee(name: "Charlie"),
		Employee(name: "Delta"),
		Employee(name: "Echo"),
		Employee(name: "Foxtrot")
	]

	func add(_ employee: Employee){
		employees.append(employee)
	}

	func delete(_ offsets: IndexSet) {
		offsets.forEach { index in
			employees.remove(at: index)
		}
	}

	init() {
		UITableViewHeaderFooterView.appearance().backgroundView = .init()
	}

	var body: some View {
		VStack {
			List {
				// MARK: Company Profile
				Section(header:
							VStack {
								HStack {
									Spacer()
									PhotoComponent(editMode: $editMode)
									Spacer()
								}
								if !editMode.isEditing {
									HStack {
										Spacer()
										Text(companyName)
											.font(.title)
										Spacer()
									}
								}
							}
							.background(Color.white)
							.textCase(.none)
				) {
					CompanyInfo()
						.padding(.vertical, 8)
					ReviewPolicy()
				}

				// MARK: - Employee List
				Section(header:
							VStack(spacing: 24) {
								HStack {
									Text("Employee")
										.font(.title3)
										.bold()
									Spacer()
									Button {
										isPinHidden.toggle()
									} label: {
										if editMode.isEditing {
											Button("Add Employee") {

											}
										} else if isPinHidden {
											Image(systemName: "eye")
										} else {
											Image(systemName: "eye.slash")
										}
									}
								}
								VStack {
									HStack {
										Text("Name")
										Spacer()
										Text("Pin")
									}
									Divider()
										.padding(.trailing, -16)
								}
								.font(.headline)
								.foregroundColor(.gray)
							}
							.background(Color.white)
							.padding(.top)
							.textCase(.none)

				) {
					ForEach(employees) { employee in
						HStack {
							Text(employee.name)
							Spacer()
							if editMode.isEditing {
								Text(employee.pin)
							} else {
								Text(isPinHidden ? "****" : employee.pin)
							}
						}
					}
					.onDelete(perform: delete)
					.foregroundColor(.gray)
				}
			}
			.listStyle(PlainListStyle())
			// MARK: Employee List -

			Spacer()
			Button("Switch to Employee role") {

			}
			.padding(.horizontal, 48)
			.padding(.vertical, 12)
			.foregroundColor(.white)
			.background(Color.AppColor.primary)
			.cornerRadius(8)
		}
		.padding(.vertical, 36)
		.navigationTitle("Company Profile")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			EditButton()
		}
		.environment(\.editMode, $editMode)
	}

	@ViewBuilder
	func CompanyInfo() -> some View {
		if editMode.isEditing {
			GeometryReader { metrics in
				HStack {
					HStack {
						Text("Company Name")
						Spacer()
					}
					.frame(width: metrics.size.width * 0.2)
					TextField("Company Inc.", text: $companyName)
				}
			}
			GeometryReader { metrics in
				HStack {
					HStack {
						Text("Owner Pin")
						Spacer()
					}
					.frame(width: metrics.size.width * 0.2)
					TextField("1234", text: $ownerPin)
				}
			}
		}
	}
	
	@ViewBuilder
	func ReviewPolicy() -> some View {
		GeometryReader { metrics in
			VStack {
				HStack {
					HStack {
						Text("Task Reviewer")
						Spacer()
					}
					.frame(width: metrics.size.width * 0.7)
					if editMode.isEditing {
						HStack {
							Stepper("\(minReviewer) Reviewer\(minReviewer > 1 ? "s" : "")") {
								minReviewer += 1
								if minReviewer > employees.count { minReviewer = employees.count }
							} onDecrement: {
								minReviewer -= 1
								if minReviewer < 0 { minReviewer = 0 }
							}
						}
					} else {
						HStack {
							Spacer()
							Text("\(minReviewer) Reviewer\(minReviewer > 1 ? "s" : "")")
						}
					}
				}
				Divider()
					.padding(.trailing, -16)
			}
		}
	}
}

struct ProfileView_Previews: PreviewProvider {
	static var previews: some View {
		PadLayout(detailView: .profile)
			.previewDevice("iPad Air (4th generation)")
			.modifier(LandscapeModifier())
	}
}

fileprivate struct LandscapeModifier: ViewModifier {
	let height = UIScreen.main.bounds.width
	let width = UIScreen.main.bounds.height

	var isPad: Bool {
		return height >= 768
	}

	var isRegularWidth: Bool {
		return height >= 414
	}

	func body(content: Content) -> some View {
		content
			.previewLayout(.fixed(width: height, height: width))
			.environment(\.horizontalSizeClass, isRegularWidth ? .regular: .compact)
			.environment(\.verticalSizeClass, isPad ? .regular: .compact)
	}
}
