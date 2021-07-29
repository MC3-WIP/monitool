//
//  CompanyOnboarding.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 28/07/21.
//

import SwiftUI
import FirebaseAuth

struct CompanyOnboarding: View {
    @ObservedObject var userAuth: AuthService
       
    var body: some View {
        Text("Company Onboarding")
        Button(action: {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                userAuth.logout()
                
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }) {
            Text("Sign Out")
        }
    }
}

struct CompanyOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        CompanyOnboarding(userAuth: .shared)
    }
}
