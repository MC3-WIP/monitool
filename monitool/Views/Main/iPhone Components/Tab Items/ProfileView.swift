//
//  ProfileView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import SwiftUI

struct ProfileView: View {
	@StateObject var viewModel = ProfileViewModel(company: Company(name: "Jake", minReview: 2, ownerPin: "2244", hasLoggedIn: true))

	@State var editMode: EditMode = .inactive {
		didSet {
			if editMode.isEditing { viewModel.isPinHidden = false }
			else { viewModel.isPinHidden = true }
		}
	}

	@ObservedObject var role: RoleService = .shared

	init() {
		UITableViewHeaderFooterView.appearance().backgroundView = .init()
	}

	var body: some View {
		VStack {
			List {
				// MARK: - Company Profile
				Section(header: CompanyProfileHeader()) {
					if editMode.isEditing {
						CompanyInfoTextField(
							title: "Company Name",
							placeholder: "Company Inc.",
							text: $viewModel.company.name
						)
						CompanyInfoTextField(
							title: "Owner PIN",
							placeholder: "1234",
							text: $viewModel.company.ownerPin
						)
					}
					ReviewPolicy()
				}

				// MARK: - Employee List
				Section(header: EmployeeListHeader()) {
					ForEach(viewModel.employees) { employee in
						EmployeeRow(employee: employee)
					}
					.onDelete(perform: viewModel.delete)
				}
			}
			.listStyle(PlainListStyle())

			Spacer()

			SwitchRoleButton()
		}
		.padding(.vertical, 36)
		.navigationTitle("Company Profile")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			if role.isOwner {
				EditButton()
			}
		}
		.sheet(isPresented: $viewModel.isPinPresenting, onDismiss: {
			role.switchRole()
		}) {
			NavigationView {

			}
			.toolbar {
				Button("Cancle") {
					viewModel.isPinPresenting = false
				}
			}
			.navigationBarTitle("Insert PIN", displayMode: .inline)
		}
		.environment(\.editMode, $editMode)
	}
}

// MARK: - View Builders
extension ProfileView {
	@ViewBuilder func CompanyProfileHeader() -> some View {
		VStack {
			HStack {
				Spacer()
				PhotoComponent(editMode: $editMode)
				Spacer()
			}
			if !editMode.isEditing {
				HStack {
					Spacer()
					Text(viewModel.company.name)
						.font(.title)
					Spacer()
				}
			}
		}
		.background(Color.white)
		.textCase(.none)
	}

	@ViewBuilder func CompanyInfoTextField(title: String, placeholder: String, text: Binding<String>) -> some View {
		GeometryReader { metrics in
			HStack {
				HStack {
					Text(title)
					Spacer()
				}
				.frame(width: metrics.size.width * 0.2)
				TextField(placeholder, text: text)
			}
		}
		.padding(.top, 4)
		.padding(.bottom, 6)
	}

	@ViewBuilder func ReviewPolicy() -> some View {
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
							Stepper(viewModel.reviewerString) {
								viewModel.incrementReviewer()
							} onDecrement: {
								viewModel.decrementReviewer()
							}
						}
					} else {
						HStack {
							Spacer()
							Text(viewModel.reviewerString)
						}
					}
				}
				Divider()
					.padding(.trailing, -16)
			}
			.padding(.top, 6)
		}
	}

	@ViewBuilder func EmployeeListHeader() -> some View {
		VStack(spacing: 24) {
			HStack {
				Text("Employee")
					.font(.title3)
					.bold()
				Spacer()
				if role.isOwner {
					Button {
						viewModel.isPinHidden.toggle()
					} label: {
						if editMode.isEditing {
							Button("Add Employee") {
								viewModel.isAddEmployeePresenting = true
							}
						} else if viewModel.isPinHidden {
							Image(systemName: "eye")
						} else {
							Image(systemName: "eye.slash")
						}
					}
					.popover(isPresented: $viewModel.isAddEmployeePresenting) {
						AddEmployeeSheetView()
							.frame(width: 400, height: 400)
							.accentColor(.AppColor.primary)
					}
				}
			}
			VStack {
				HStack {
					Text("Name")
					Spacer()
					if role.isOwner {
						Text("Pin")
					}
				}
				Divider()
					.padding(.trailing, -16)
			}
			.font(.headline)
			.foregroundColor(.gray)
		}
		.background(Color.white)
		.padding(.top, 28)
		.textCase(.none)
	}

	@ViewBuilder func EmployeeRow(employee: Employee) -> some View {
		HStack {
			Text(employee.name)
			Spacer()
			if role.isOwner {
				if editMode.isEditing {
					Text(employee.pin)
				} else {
					Text(viewModel.isPinHidden ? "****" : employee.pin)
				}
			}
		}
		.foregroundColor(.gray)
	}

	@ViewBuilder func SwitchRoleButton() -> some View {
		Button("Switch to \(role.isOwner ? "Employee" : "Owner") role") {
			if role.isOwner {
				RoleService.shared.switchRole()
			} else {
				viewModel.isPinPresenting = true
			}
		}
		.padding(.horizontal, 48)
		.padding(.vertical, 12)
		.foregroundColor(.white)
		.background(editMode.isEditing ? Color.AppColor.primary.opacity(0.5) : Color.AppColor.primary)
		.cornerRadius(8)
		.disabled(editMode.isEditing)
	}
}

// MARK: - Preview
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
