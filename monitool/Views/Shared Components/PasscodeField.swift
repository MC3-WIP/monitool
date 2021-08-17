//
//  PasscodeField.swift
//  monitool
//
//  Created by Naufaldi Athallah Rifqi on 16/08/21.
//

import SwiftUI
import Introspect

public struct PasscodeField: View {
    
    var maxDigits = 4
    var label = "Enter Pin for Owner"
    
    @State var showPin = false
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    var handler: (String, (Bool) -> Void) -> Void
    
    public var body: some View {
        VStack(spacing: 30) {
            Text(label).font(.title)
            ZStack {
                pinDots
                backgroundField
            }
            showPinStack
            if !profileViewModel.isPinRight {
                Text("Wrong pin")
            }
        }
        
    }
    
    private var pinDots: some View {
        HStack {
            Spacer()
            ForEach(0..<maxDigits) { index in
                Image(systemName: self.getImageName(at: index))
                    .font(.system(size: 30, weight: .thin, design: .default))
                Spacer()
            }
        }
    }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { profileViewModel.pinInputted }, set: { newValue in
            profileViewModel.pinInputted = newValue
            self.submitPin()
        })
        
        return TextField("", text: boundPin, onCommit: submitPin)
      
      // Introspect library can used to make the textField become first resonder on appearing
      // if you decide to add the pod 'Introspect' and import it, comment #50 to #53 and uncomment #55 to #61
      
//           .accentColor(.clear)
//           .foregroundColor(.clear)
//           .keyboardType(.numberPad)
//           .disabled(isDisabled)
      
             .introspectTextField { textField in
                textField.tintColor = .clear
                textField.textColor = .clear
                textField.keyboardType = .numberPad
                textField.becomeFirstResponder()
                textField.isEnabled = !profileViewModel.isPasscodeFieldDisabled
         }
    }
    
    private var showPinStack: some View {
        HStack {
            Spacer()
            if !profileViewModel.pinInputted.isEmpty {
                showPinButton
            }
        }
        .frame(height: 20)
        .padding([.trailing])
    }
    
    private var showPinButton: some View {
        Button(action: {
            self.showPin.toggle()
        }, label: {
            self.showPin ?
                Image(systemName: "eye.slash.fill").foregroundColor(.primary) :
                Image(systemName: "eye.fill").foregroundColor(.primary)
        })
    }
    
    private func submitPin() {
        guard !profileViewModel.pinInputted.isEmpty else {
            showPin = false
            return
        }
        
        if profileViewModel.pinInputted.count == maxDigits {
            profileViewModel.isPasscodeFieldDisabled = true
            
            handler(profileViewModel.pinInputted) { isSuccess in
                if isSuccess {
                    print("pin matched, go to next page, no action to perfrom here")
                } else {
                    profileViewModel.pinInputted = ""
                    profileViewModel.isPasscodeFieldDisabled = false
                    print("this has to called after showing toast why is the failure")
                }
            }
        }
        
        // this code is never reached under  normal circumstances. If the user pastes a text with count higher than the
        // max digits, we remove the additional characters and make a recursive call.
        if profileViewModel.pinInputted.count > maxDigits {
            profileViewModel.pinInputted = String(profileViewModel.pinInputted.prefix(maxDigits))
            submitPin()
        }
    }
    
    private func getImageName(at index: Int) -> String {
        if index >= profileViewModel.pinInputted.count {
            return "circle"
        }
        
        if self.showPin {
            return profileViewModel.pinInputted.digits[index].numberString + ".circle"
        }
        
        return "circle.fill"
    }
}
