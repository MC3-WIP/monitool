//
//  ContentView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 21/07/21.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @ObservedObject var userAuth: AuthService = .shared

	var body: some View {
        if userAuth.isLoggedIn {
            CompanyOnboarding(userAuth: self.userAuth)
//			EmployeeListView()
        } else {
            SignIn(userAuth: self.userAuth)
//            CompanyOnboarding(userAuth: self.userAuth)
        }
			// PhotoComponent()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
