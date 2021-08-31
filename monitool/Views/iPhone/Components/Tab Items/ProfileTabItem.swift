//
//  ProfileView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 30/07/21.
//

import SwiftUI
import Combine

extension ProfileTabItem {
    class ViewModel: ObservableObject {
        @Published var company: Company?
        @Published var employees = [Employee]()

        private var subscriptions = Set<AnyCancellable>()

        // View Properties
        var imageUrl: String {
            company?.profileImage ?? ""
        }

        var ownerPin: String {
            company?.ownerPin ?? ""
        }

        var minReviewer: Int {
            company?.minReview ?? 0
        }

        var companyName: String {
            company?.name ?? ""
        }

        var hasChanges: Bool {
            companyNameField != companyName
                || ownerPinField != ownerPin
                || minReviewerField != minReviewer
        }

        // Fields
        @Published var minReviewerField = 0
        @Published var ownerPinField: String = "" {
            didSet {
                if ownerPinField.count > 4 {
                    ownerPinField = String(ownerPinField.prefix(4))
                }
            }
        }
        @Published var companyNameField = ""

        init() {
            EmployeeRepository.shared.$employees
                .assign(to: \.employees, on: self)
                .store(in: &subscriptions)

            CompanyRepository.shared.$company
                .sink { company in
                    if let company = company {
                        self.company = company
                        self.companyNameField = company.name
                        self.ownerPinField = company.ownerPin
                    }
                }
                .store(in: &subscriptions)
        }

        func delete(_ indexSet: IndexSet) {
            indexSet.forEach { index in
                EmployeeRepository.shared.delete(employees[index])
            }
        }

        func update() {
            CompanyRepository.shared.companyRef?.updateData([
                "minReview": minReviewerField,
                "name": companyNameField,
                "ownerPin": ownerPinField
            ])
        }

        func resetFields() {
            companyNameField  = companyName
            ownerPinField     = ownerPin
            minReviewerField  = minReviewer
        }
    }
}

struct ProfileTabItem: View {
    @StateObject var viewModel = ViewModel()

    @State var editMode: EditMode = .inactive
    @State var pinHidden = true
    @State var sheetPresenting = false
    @State var alertPresenting = false

    var body: some View {
        NavigationView {
            if viewModel.company == nil {
                ProgressView()
                    .navigationBarTitle("Company Profile", displayMode: .inline)
            } else {
                content
            }
        }
    }

    private var content: some View {
        VStack {
            // Photo
            PhotoComponent(imageURL: viewModel.imageUrl, editMode: $editMode)

            // Company Name
            renderCompanyName()

            Spacer(minLength: 32)

            // if edit: Edit Name, Pin, and Min. Reviewer
            // else: Owner Pin and Review Policy
            routeEditMode()

            // Employee List
            renderEmployeeList()
        }
        .padding(.top, 32)
        .navigationBarTitle("Company Profile", displayMode: .inline)
        .toolbar { EditButton() }
        .environment(\.editMode, $editMode)
        .onChange(of: editMode) { value in
            pinHidden = !value.isEditing
            if viewModel.companyNameField.isEmpty ||
                viewModel.ownerPinField.isEmpty {
                alertPresenting.toggle()
            } else if viewModel.hasChanges {
                viewModel.update()
            }
        }
        .sheet(isPresented: $sheetPresenting) {
            AddDataPopOver(
                sheetType: "Employee",
                showingPopOver: $sheetPresenting
            ).accentColor(AppColor.accent)
        }
        .alert(isPresented: $alertPresenting) {
            Alert(
                title: Text("Missing Information"),
                message: Text("Company Name and Owner PIN shall not be empty."),
                dismissButton: .default(Text("Got it!")) {
                    viewModel.resetFields()
                }
            )
        }
    }
}

// MARK: Components
extension ProfileTabItem {
    @ViewBuilder
    func renderCompanyName() -> some View {
        if !editMode.isEditing {
            HStack(alignment: .center) {
                Text(viewModel.companyName)
                    .font(.title2.weight(.medium))
                    .multilineTextAlignment(.center)
            }.padding(.horizontal, 36)
        }
    }

    @ViewBuilder
    func renderRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
                .fontWeight(.semibold)
        }.padding(.horizontal, 18)
        Divider()
    }

    @ViewBuilder
    func routeEditMode() -> some View {
        if editMode.isEditing {
            // Edit Company Name
            HStack {
                Text("Company Name")
                    .foregroundColor(.gray)
                Spacer()
                TextField("Company Inc.", text: $viewModel.companyNameField)
                    .multilineTextAlignment(.trailing)
            }.padding(.horizontal, 18)

            Divider()

            // Edit Owner PIN
            HStack {
                Text("Owner PIN")
                    .foregroundColor(.gray)
                Spacer()
                TextField("1234", text: $viewModel.ownerPinField)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
            }.padding(.horizontal, 18)

            Divider()

            // Edit Review Policy
            HStack {
                Text("\(viewModel.minReviewerField) Task Reviewer")
                    .foregroundColor(.gray)
                Spacer()
                Stepper(
                    value: $viewModel.minReviewerField,
                    in: (0...viewModel.employees.count)
                ) {}
            }.padding(.horizontal, 18)

            Divider()
        } else {
            // Owner Pin
            renderRow(title: "Owner PIN", value: viewModel.ownerPin)

            // Review Policy
            renderRow(title: "Task Reviewer", value: "\(viewModel.minReviewer) Reviewer")
        }
    }

    @ViewBuilder
    func renderEmployeeList() -> some View {
        HStack {
            Text("Employee")
                .font(.title3)
                .bold()
            Spacer()
            if editMode.isEditing {
                Button {
                    sheetPresenting.toggle()
                } label: {
                    Image(systemName: "plus.circle").font(.title3)
                }
            } else {
                Button {
                    pinHidden.toggle()
                } label: {
                    Image(systemName: pinHidden ? "eye" : "eye.slash")
                }
            }
        }
        .padding(18)
        .padding(.bottom, -16)
        HStack {
            Text("Name")
            Spacer()
            Text("PIN")
        }
        .font(.headline)
        .foregroundColor(.gray)
        .padding(.horizontal, 18)
        List {
            ForEach(viewModel.employees, id: \.id) { employee in
                renderEmployeeRow(for: employee).deleteDisabled(!editMode.isEditing)
            }.onDelete(perform: viewModel.delete)
        }
        .listStyle(PlainListStyle())
    }

    @ViewBuilder
    func renderEmployeeRow(for employee: Employee) -> some View {
        HStack {
            Text(employee.name)
            Spacer()
            Text(pinHidden ? "****" : employee.pin)
                .foregroundColor(.gray)
        }
    }
}

struct ProfileTabItem_Previews: PreviewProvider {
    static var previews: some View {
        PhoneLayout(selectedTab: .profile)
    }
}
