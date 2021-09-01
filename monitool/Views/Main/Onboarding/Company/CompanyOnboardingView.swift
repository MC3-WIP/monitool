//
//  CompanyOnboarding.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 28/07/21.
//
import FirebaseAuth
import SwiftUI

struct CompanyOnboardingView: View {
    @State var minReviewers = 0
    @State var companyName: String = ""
    @State private var showingSheet = false
    @State private var showingAlert = false
    @StateObject var ownerPin = TextBindingHelper(limit: 4)
    @State private var device = UIDevice.current.userInterfaceIdiom
    @ObservedObject var employeeViewModel: EmployeeListViewModel = .shared
    @ObservedObject var companyViewModel: CompanyViewModel = .shared
    @ObservedObject var storageService: StorageService = .shared
    @ObservedObject var userAuth: AuthService = .shared

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Color.clear
                        .frame(width: 0, height: 0)
                        .accessibilityHidden(true)) {
                            HStack {
                                Spacer()
                                PhotoComponent(imageURL: "", editMode: .constant(.active))
                                Spacer()
                            }
                            HStack {
                                Text("Company Name")
                                TextField("Company Name", text: $companyName).multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("Owner Pin")
                                TextField("Owner Pin", text: $ownerPin.text)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.numberPad)
                            }
                            HStack {
                                Text("Task Reviewer: ")
                                Spacer()
                                Stepper("\(minReviewers) Reviewer(s)", onIncrement: {
                                    if minReviewers < employeeViewModel.employees.count {
                                        minReviewers += 1
                                    }
                                }, onDecrement: {
                                    if minReviewers > 0 {
                                        minReviewers -= 1
                                    }
                                })
                            }
                    }
                    Section(
                        header: HStack {
                            Text("Employee")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Button("Add Employee") {
                                showingSheet = true
                            }
                            .popover(isPresented: $showingSheet) {
                                if device == .pad {
                                    AddDataPopOver(sheetType: "Employee", showingPopOver: $showingSheet)
                                        .frame(width: 400, height: 400)
                                } else {
                                    AddDataPopOver(sheetType: "Employee", showingPopOver: $showingSheet)
                                }
                            }
                        }
                    ) {
                        HStack {
                            Text("Name").foregroundColor(.gray)
                            Spacer()
                            Text("Pin").foregroundColor(.gray)
                        }
                        ForEach(employeeViewModel.employees) { employee in
                            HStack {
                                Text(employee.name)
                                Spacer()
                                Text(employee.pin)
                            }
                        }
                        .onDelete(perform: employeeViewModel.delete)
                    }.textCase(nil)
                }.listStyle(GroupedListStyle())
            }.navigationBarTitle("Profile", displayMode: .inline)
            .toolbar {
                Button("Save") {
                    if companyName == "" || ownerPin.text == "" {
                            showingAlert = true
                    } else {
                        let company = Company(
                            name: companyName,
                            minReview: minReviewers,
                            ownerPin: ownerPin.text,
                            hasLoggedIn: true,
                            profileImage: ""
                        )
                        companyViewModel.create(company)
                        storageService.updateImageURL(category: "profile")
                        userAuth.hasLogin()
                    }
                }
            }.alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Missing Info"),
                    message: Text("Please input your company name and a PIN before proceeding."),
                    dismissButton: .default(Text("Got it!"))
                )
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .accentColor(AppColor.accent)
    }
}

struct CompanyOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        CompanyOnboardingView()
    }
}
