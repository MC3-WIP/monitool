//
//  CompanyOnboarding.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 28/07/21.
//

import SwiftUI
import FirebaseAuth

struct CompanyOnboardingView: View {
    @State var minReviewers = 0
    @State var companyName: String = ""
    @State private var showingSheet = false
    @State var isLinkActive = false
    @ObservedObject var employeeViewModel = EmployeeListViewModel()
    @ObservedObject var companyViewModel = CompanyViewModel()
    @ObservedObject var storageService = StorageService()
    @ObservedObject var userAuth: AuthService
    
    init() {
        self.userAuth = .shared
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Color.clear
                                .frame(width: 0, height: 0)
                                .accessibilityHidden(true)) {
                        HStack() {
                            Spacer()
							PhotoComponent(editMode: .constant(.inactive))
                            Spacer()
                        }
                        HStack() {
                            Text("Company Name")
                            TextField("Company Name", text: $companyName).multilineTextAlignment(.trailing)
                        }
                        HStack() {
                            Text("Task Reviewer: ")
                            Spacer()
                            Stepper("\(minReviewers) Reviewer(s)", onIncrement: {
                                minReviewers += 1
                            }, onDecrement: {
                                if minReviewers > 0 {
                                    minReviewers -= 1
                                }
                            })
                        }
                    }
                    Section(header: HStack() {
                        Text("Employee").font(.title2).foregroundColor(.black).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Button("Add Employee") {
                            showingSheet = true
                        }
                        .popover(isPresented: $showingSheet) {
                            AddEmployeeSheetView(sheetType: "Employee").frame(width: 400, height: 400)
                        }
                    }, footer: HStack() {
                        Spacer()
                        Button("Save", action: {
                            self.isLinkActive = true
                            let company = Company(name: companyName, minReview: minReviewers, ownerPin: "3344", hasLoggedIn: true)
                            companyViewModel.create(company)
                            userAuth.hasLogin()
                        })
                        .padding()
                        .background(Color.AppColor.primary)
                        .foregroundColor(.white)
                        .clipShape(Rectangle())
                        .cornerRadius(10)
                        Spacer()
                    }
                    ) {
                        HStack() {
                            Text("Name").foregroundColor(.gray)
                            Spacer()
                            Text("Pin").foregroundColor(.gray)
                        }
                        ForEach(employeeViewModel.employees) { employee in
                            HStack() {
                                Text(employee.name)
                                Spacer()
                                Text(employee.pin)
                            }
                        }
                        .onDelete(perform: employeeViewModel.delete)
                    }.textCase(nil)
                    
                }.listStyle(GroupedListStyle())
            }.navigationTitle("Profile").navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func saveCompanyData(company: Company) {
        
    }
}

struct CompanyOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        CompanyOnboardingView()
    }
}
