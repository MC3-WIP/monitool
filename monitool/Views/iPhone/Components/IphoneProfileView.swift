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

    var company: Company?

    @State var companyName = ""
    
    
    @State var editMode: EditMode = .inactive {
        didSet {
            if editMode.isEditing { profileViewModel.isPinHidden = false } else { profileViewModel.isPinHidden = true }
        }
    }
    
    var body: some View {
        VStack{
            List{
                Section(h)
            }
        }
    }
}

extension IphoneReviseView{
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
}

struct IphoneProfileView_Previews: PreviewProvider {
    static var previews: some View {
        IphoneProfileView()
    }
}
