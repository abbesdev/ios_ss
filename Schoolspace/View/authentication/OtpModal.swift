//
//  SignupModal.swift
//  School space
//
//  Created by Mohamed Abbes on 16/3/2023.
//

import SwiftUI
import Combine

struct OtpModal: View {

    @Environment(\.presentationMode) var presentationMode
    @State private var isVerifyModalShown1 = false
    @State private var selectedOption = 1
    @State private var otp = ""
    @State var viewModel = SignupViewModel()


  
    var body: some View {

            VStack (alignment:.center, spacing: 8){
                
                Image("icon_exit")
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture(perform: {
                        self.presentationMode.wrappedValue.dismiss()
                        
                    })
                
                
                Text("Verify your account step 2")
                    .padding(.leading) .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.bold)
                
                Text("Please type in the received otp code")
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.light)
                
                
                PasscodeField(pin: Binding(projectedValue: $otp)) { pin, completionHandler in
                    if pin == UserDefaults.standard.string(forKey: "otp") {
                        // The PIN matches the OTP, call the view model function to verify the user
                        
                        completionHandler(true)
                    } else {
                        // The PIN does not match, clear the input
                        
                        completionHandler(false)
                    }
                }
                .padding(20)
                
                
                
                
                
                Spacer()
                Button(action: {
                    if otp == UserDefaults.standard.string(forKey: "otp") {
                        // The OTP matches the PIN, call the view model function to verify the user
                        viewModel.verifyUser()
                        print("trigger condiftion")
                        if viewModel.redirectToLogin == true {
                                   // Dismiss all previous sheets
                                   presentationMode.wrappedValue.dismiss()
                                 
                               }
                        
                        
                    } else {
                        // The OTP does not match the PIN, show an error message
                        print("Invalid OTP")
                    }
                    print("trigger outside")
                }) {
                    Text("Finish set up")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .foregroundColor(.white)
                .background(Color(0xFF016DB1))
                .cornerRadius(10)
                .padding()

                
                
            }
            .padding(.top,16)
        }
        
    
    
}

struct OtpModal_Previews: PreviewProvider {
    static var previews: some View {
        OtpModal()
    }
}



public struct PasscodeField: View {
    
    var maxDigits: Int = 4
    var label = "Enter the otp code sent to you"
    
    @Binding var pin: String // Use Binding instead of State
    @State var showPin = false
    @State var isDisabled = false
    
    
    var handler: (String, (Bool) -> Void) -> Void
    
    public var body: some View {
        VStack(spacing: 40) {
            Text(label)
            ZStack {
                pinDots
                backgroundField
            }
            showPinStack
        }
        
    }
    
    private var pinDots: some View {
        HStack {
            Spacer()
            ForEach(0..<maxDigits) { index in
                Image(systemName: self.getImageName(at: index))
                    .font(.system(size: 70, weight: .thin , design:.default))
                    
                Spacer()
            }
        }
    }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
            self.pin = newValue
            self.submitPin()
        })
        
        return TextField("", text: boundPin, onCommit: submitPin)
      
      // Introspect library can used to make the textField become first resonder on appearing
      // if you decide to add the pod 'Introspect' and import it, comment #50 to #53 and uncomment #55 to #61
      
           .accentColor(.clear)
           .foregroundColor(.clear)
           .keyboardType(.numberPad)
           .disabled(isDisabled)
      
//             .introspectTextField { textField in
//                 textField.tintColor = .clear
//                 textField.textColor = .clear
//                 textField.keyboardType = .numberPad
//                 textField.becomeFirstResponder()
//                 textField.isEnabled = !self.isDisabled
//         }
    }
    
    private var showPinStack: some View {
        HStack {
            Spacer()
            if !pin.isEmpty {
                showPinButton
            }
        }
        .frame(height: 80)
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
        guard !pin.isEmpty else {
            showPin = false
            return
        }
        
        if pin.count == maxDigits {
            isDisabled = true
            
            handler(self.pin) { isSuccess in
                if isSuccess {
                    print("pin matched, go to next page, no action to perfrom here")
                } else {
                    // clear the pin field
                   
                    print("this has to called after showing toast why is the failure")
                }
            }
        }
        
        // this code is never reached under  normal circumstances. If the user pastes a text with count higher than the
        // max digits, we remove the additional characters and make a recursive call.
        if pin.count > maxDigits {
            pin = String(pin.prefix(maxDigits))
            submitPin()
        }
    }


    
    private func getImageName(at index: Int) -> String {

        if index >= self.pin.count {
            return "circle"
        }
        
        if self.showPin {
            return self.pin.digits[index].numberString + ".circle"
        }
        
        return "circle.fill"
    }
}

extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }
    
}

extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}
