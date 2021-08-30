//
//  ProfileView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 01/08/21.
//

import SwiftUI

struct ProfileView: View {
	@State var isPinTrue: Bool?
	@State var editMode: EditMode = .inactive {
		didSet {
			if editMode.isEditing { profileViewModel.isPinHidden = false } else { profileViewModel.isPinHidden = true }
		}
	}

    @ObservedObject var ownerPin = TextLimiter(limit: 4)
    @ObservedObject var employeeListViewModel = EmployeeListViewModel()
    @ObservedObject var role: RoleService = .shared
    @State var editMode: EditMode = .inactive {
        didSet {
            if editMode.isEditing { profileViewModel.isPinHidden = false } else { profileViewModel.isPinHidden = true }
        }
    }
    @ObservedObject var profileViewModel: ProfileViewModel = .shared
    var body: some View {
        VStack {
            List {
                // MARK: - Company Profile
                Section(header: CompanyProfileHeader()) {
                    if editMode.isEditing {
                        GeometryReader { metrics in
                            HStack {
                                HStack {
                                    Text("Company Name")
                                    Spacer()
                                }
                                .frame(width: metrics.size.width * 0.2)
                                TextField("Company Inc.", text: $profileViewModel.company.name)
                                    .onChange(of: profileViewModel.company.name) { value in
                                        profileViewModel.company.name = value
                                    }
                                    
                            }
                        }
                        .padding(.top, 4)
                        .padding(.bottom, 6)
                        GeometryReader { metrics in
                            HStack {
                                HStack {
                                    Text("Owner PIN")
                                    Spacer()
                                }
                                .frame(width: metrics.size.width * 0.2)
                                TextField(profileViewModel.company.ownerPin, text: $ownerPin.value)
                                    .onChange(of: profileViewModel.company.ownerPin) { value in
                                        if value.count < 4{
                                            
                                        }
                                        else{
                                            profileViewModel.company.ownerPin = value
                                        }
                                    }
                                    
                                    
                            }
                        }
                        .padding(.top, 4)
                        .padding(.bottom, 6)
                    }
                    ReviewPolicy()
                }

                // MARK: - Employee List
                
                Section(header: EmployeeListHeader()) {
                    ForEach(employeeListViewModel.employees) { employee in
                        EmployeeRow(employee: employee)
                    }
                    .onDelete(perform: employeeListViewModel.delete)
                }
            }
            .listStyle(InsetGroupedListStyle())
            Spacer()
            SwitchRoleButton()
        }
        .padding(.vertical, 36)
        .navigationBarTitle("Profile", displayMode: .inline)
        .toolbar {
            if role.isOwner {
                EditButton()
            }
        }
        .sheet(isPresented: $profileViewModel.isPinPresenting) {
            PasscodeField(isPinTrue: $isPinTrue) { inputtedPin, _ in
                if inputtedPin == profileViewModel.company.ownerPin {
                    print("sukses")
                    role.switchRole(to: .owner)
                    profileViewModel.isPinPresenting = false
                    isPinTrue = true
                    hideKeyboard()
                } else {
                    profileViewModel.pinInputted = ""
                    profileViewModel.isPasscodeFieldDisabled = false
                    isPinTrue = false
                }
            }
        }
        .environment(\.editMode, $editMode)
        .onChange(of: editMode, perform: { value in
            if !value.isEditing {
                profileViewModel.updateCompany(
                    companyName: profileViewModel.company.name,
                    companyPIN: profileViewModel.company.ownerPin,
                    minReview: profileViewModel.company.minReview
                )
            }
        })
    }
}

// MARK: - View Builders

extension ProfileView {
    @ViewBuilder func CompanyProfileHeader() -> some View {
        VStack {
            HStack {
                Spacer()
                PhotoComponent(imageURL: profileViewModel.company.profileImage ?? "", editMode: $editMode)
                Spacer()
            }
            if !editMode.isEditing {
                HStack {
                    Text(profileViewModel.company.name)
                        .font(.title)
                }
            }
        }
        .background(AppColor.primaryForeground)
        .textCase(.none)
    }

    @ViewBuilder func ReviewPolicy() -> some View {
        let max = employeeListViewModel.employees.count
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
                            Stepper(
                                "\(profileViewModel.company.minReview)",
                                value: $profileViewModel.company.minReview, in: 0 ... max - 1
                            )
                        }
                    } else {
                        HStack {
                            Spacer()
                            Text(profileViewModel.reviewerString)
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
                        profileViewModel.isPinHidden.toggle()
                    } label: {
                        if editMode.isEditing {
                            Button("Add Employee") {
                                profileViewModel.isAddEmployeePresenting = true
                            }
                        } else if profileViewModel.isPinHidden {
                            Image(systemName: "eye")
                        } else {
                            Image(systemName: "eye.slash")
                        }
                    }
                    .popover(isPresented: $profileViewModel.isAddEmployeePresenting) {
                        AddDataPopOver(sheetType: "Employee", showingPopOver: $profileViewModel.isAddEmployeePresenting)
                            .frame(width: 400, height: 400)
                            .accentColor(AppColor.accent)
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
        .background(AppColor.primaryForeground)
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
                    Text(profileViewModel.isPinHidden ? "****" : employee.pin)
                }
            }
        }
        .foregroundColor(.gray)
    }

    @ViewBuilder func SwitchRoleButton() -> some View {
        Button("Switch to \(role.isOwner ? "Employee" : "Owner") role") {
            if role.isOwner {
                RoleService.shared.switchRole(to: .employee)
            } else {
                profileViewModel.isPinPresenting = true
            }
        }
        .padding(.horizontal, 48)
        .padding(.vertical, 12)
        .foregroundColor(AppColor.primaryForeground)
        .background(editMode.isEditing ? AppColor.accent.opacity(0.5) : AppColor.accent)
        .cornerRadius(8)
        .disabled(editMode.isEditing)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Preview

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .previewDevice("iPad Air (4th generation)")
    }
}

private struct LandscapeModifier: ViewModifier {
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
            .environment(\.horizontalSizeClass, isRegularWidth ? .regular : .compact)
            .environment(\.verticalSizeClass, isPad ? .regular : .compact)
    }
}
