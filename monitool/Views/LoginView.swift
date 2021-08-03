//
//  LoginView.swift
//  monitool
//
//  Created by Mac-albert on 30/07/21.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var userAuth: AuthService = .shared
    var body: some View {
        VStack(){
            Image("kucing1")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .padding(.bottom, 70.0)
            Text("Monitool")
                .font(.system(size: 34, weight: .regular))
                .padding(.bottom, 17.0)
            Text("Manage your Employee")
                .padding(.bottom, 72.0)
            SignIn(userAuth: userAuth)
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
