//
//  ContentView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 21/07/21.
//

import SwiftUI
import CoreData
import CryptoKit
import FirebaseAuth
import AuthenticationServices

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @ObservedObject var userAuth: UserAuth = .shared
    
    @State var currentNonce:String?
    
    //Hashing function using CryptoKit
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    // from https://firebase.google.com/docs/auth/ios/apple
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    var body: some View {
        if userAuth.isLoggedIn {
            CompanyOnboarding(userAuth: self.userAuth)
        } else {
            SignInWithAppleButton(
                onRequest: { request in
                    let nonce = randomNonceString()
                    currentNonce = nonce
                    request.requestedScopes = [.fullName, .email]
                    request.nonce = sha256(nonce)
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            
                            guard let nonce = currentNonce else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let appleIDToken = appleIDCredential.identityToken else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                return
                            }
                            
                            let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                            Auth.auth().signIn(with: credential) { (authResult, error) in
                                if (error != nil) {
                                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                                    // you're sending the SHA256-hashed nonce as a hex string with
                                    // your request to Apple.
                                    print(error?.localizedDescription as Any)
                                    return
                                }
                                print("signed in")
                                userAuth.login()
                                
                            }
                            
                            print("\(String(describing: Auth.auth().currentUser?.uid))")
                            
                        default:
                            break
                            
                        }
                    default:
                        break
                    }
                }
            ).frame(width: 280, height: 45, alignment: .center)
        }
        
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
