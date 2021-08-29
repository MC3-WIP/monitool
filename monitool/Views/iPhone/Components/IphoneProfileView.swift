//
//  IphoneProfileView.swift
//  monitool
//
//  Created by Mac-albert on 18/08/21.
//

import SwiftUI

struct IphoneProfileView: View {
    @State var editModeIphone: EditMode = .inactive {
        didSet {
            if editModeIphone.isEditing {
                profileViewModel.isPinHidden = false
            } else {
                profileViewModel.isPinHidden = true
            }
        }
	}

    @StateObject var profileViewModel = ProfileViewModel()
    @StateObject var ownerPin = TextLimiter(limit: 4)

	@ObservedObject var role: RoleService = .shared
	@ObservedObject var employeeListViewModel: EmployeeListViewModel = .shared

    var body: some View {
        VStack {
            List {
                Section(header: CompanyProfileHeader()) {
                    if editModeIphone.isEditing {
                        CompanyInfoNameTextField(
                            placeholder: "Company Inc.",
                            text: $profileViewModel.company.name
                        )
                        .onChange(of: profileViewModel.company.name) { value in
                            profileViewModel.company.name = value
                        }
                        CompanyInfoTextField(
                            title: "Owner PIN",
                            placeholder: profileViewModel.company.ownerPin,
                            text: $ownerPin.value
                        )
                        .onChange(of: profileViewModel.company.ownerPin) { value in
                            if value.count == 4 {
                                profileViewModel.company.ownerPin = value
                            }
                        }
                    }
                    ReviewPolicy()
                }
//                .frame(width: UIScreen.main.bounds.size.width)
                Section(header: EmployeeListHeader()) {
                    ForEach(employeeListViewModel.employees) { employee in
                        EmployeeRow(employee: employee)
                    }
                    .onDelete(perform: employeeListViewModel.delete)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .onAppear {
                UITableView.appearance().separatorColor = .clear
            }
        }
        .padding(.vertical, 10)
        .toolbar {
            EditButton()
        }
        .navigationBarTitle("Profile", displayMode: .inline)
        .environment(\.editMode, $editModeIphone)
    }
}

extension IphoneProfileView {
    @ViewBuilder func CompanyProfileHeader() -> some View {
        VStack {
            HStack {
                Spacer()
                PhotoComponent(imageURL: profileViewModel.company.profileImage ?? "", editMode: $editModeIphone)
                Spacer()
            }
            if !editModeIphone.isEditing {
                HStack {
                    Text(profileViewModel.company.name)
                        .font(.title)
                }
            }
        }
        .background(AppColor.primaryForeground)
        .textCase(.none)
    }

    @ViewBuilder func CompanyInfoTextField(title: String, placeholder: String, text: Binding<String>) -> some View {
        GeometryReader { metrics in
            HStack {
                HStack {
                    Text(title)
                    Spacer()
                }
                .frame(width: metrics.size.width * 0.35)
                Spacer()
                TextField(placeholder, text: text)
                    .frame(alignment: .trailing)
            }
        }
        .padding(.top, 4)
        .padding(.bottom, 6)
    }

    @ViewBuilder func CompanyInfoNameTextField(placeholder: String, text: Binding<String>) -> some View {
        HStack {
            TextField(placeholder, text: text)
        }
        .padding(.top, 4)
        .padding(.bottom, 6)
    }

    @ViewBuilder func ReviewPolicy() -> some View {
        VStack {
            HStack {
                if editModeIphone.isEditing {
                    HStack {
                        Stepper(profileViewModel.reviewerString) {
                            profileViewModel.incrementReviewer()
                        } onDecrement: {
                            profileViewModel.decrementReviewer()
                        }
                    }
                } else {
                    LazyVStack(spacing: 10) {
                        HStack {
                            Text("Owner Pin")
                            Spacer()
                            Text(profileViewModel.company.ownerPin)
                        }
                        HStack {
                            Text("Task Reviewer")
                            Spacer()
                            Text(profileViewModel.reviewerString)
                        }
                    }
                    .padding(.bottom, 15)
                }
            }
            Divider()
                .padding(.trailing, -16)
        }
        .padding(.top, 6)
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
                        if editModeIphone.isEditing {
                            Button {
                                profileViewModel.isAddEmployeePresenting = true
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                        } else if profileViewModel.isPinHidden {
                            Image(systemName: "eye")
                        } else {
                            Image(systemName: "eye.slash")
                        }
                    }
                    .popover(isPresented: $profileViewModel.isAddEmployeePresenting) {
                        AddDataPopOver(sheetType: "Employee", showingPopOver: $profileViewModel.isAddEmployeePresenting)
                            .frame(width: 400, height: .infinity)
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
                if editModeIphone.isEditing {
                    Text(employee.pin)
                } else {
                    Text(profileViewModel.isPinHidden ? "****" : employee.pin)
                }
            }
        }
        .foregroundColor(.gray)
    }
}

struct IphoneProfileView_Previews: PreviewProvider {
    static var previews: some View {
        IphoneProfileView()
    }
}
