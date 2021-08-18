//
//  IphoneProfileView.swift
//  monitool
//
//  Created by Mac-albert on 18/08/21.
//

import SwiftUI

struct IphoneProfileView: View {
    @StateObject var companyViewModel = CompanyViewModel()
    @StateObject var profileViewModel = ProfileViewModel()

    @ObservedObject var employeeListViewModel = EmployeeListViewModel()
    @ObservedObject var role: RoleService = .shared

    var company: Company?

    @State var companyName = ""
    @State var editMode: EditMode = .inactive {
        didSet {
            if editMode.isEditing { profileViewModel.isPinHidden = false } else { profileViewModel.isPinHidden = true }
        }
    }
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 10) {
                    Section(header: CompanyProfileHeader()) {
                        if editMode.isEditing {
                            CompanyInfoTextField(
                                title: "Company Name",
                                placeholder: "Company Inc.",
                                text: $profileViewModel.company.name
                            )
                            CompanyInfoTextField(
                                title: "Owner PIN",
                                placeholder: "1234",
                                text: $profileViewModel.company.ownerPin
                            )
                        }
                        ReviewPolicy()
                    }
                    Spacer()
                    Section(header: EmployeeListHeader()) {
                        ForEach(employeeListViewModel.employees) { employee in
                            EmployeeRow(employee: employee)
                        }
                        .onDelete(perform: employeeListViewModel.delete)
                    }
                }
            }
        }
        .padding()
    }
}

extension IphoneProfileView {
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
                            Stepper(profileViewModel.reviewerString) {
                                profileViewModel.incrementReviewer()
                            } onDecrement: {
                                profileViewModel.decrementReviewer()
                            }
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
}

struct IphoneProfileView_Previews: PreviewProvider {
    static var previews: some View {
        IphoneProfileView()
    }
}
