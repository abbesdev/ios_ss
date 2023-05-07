//
//  SignupModal.swift
//  School space
//
//  Created by Mohamed Abbes on 16/3/2023.
//

import SwiftUI

struct VerifyAccountModal: View {

    @Environment(\.presentationMode) var presentationMode
    @State private var isVerifyModalShown1 = false
    @State private var selectedOption = 1


  
    var body: some View {
        VStack (alignment:.center, spacing: 8){
            
            Image("icon_exit")
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture(perform: {
                    self.presentationMode.wrappedValue.dismiss()
                    
                })
            
            
            Text("Verify your account")
                .padding(.leading) .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.bold)
            
            Text("Please select verification method")
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.light)
            VStack (spacing:16){
                Button(action: {
                                selectedOption = 1
                            }) {
                                HStack {
                                    Text("Verify with phone number")
                                        .foregroundColor(selectedOption == 1 ? .white : .black)
                                    Spacer()
                                    Image(systemName: selectedOption == 1 ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(Color(0xFF016DB1))
                                }
                                .padding()
                                .background(selectedOption == 1 ? Color(0xFF016DB1) : Color.gray.opacity(0.1))
                                .cornerRadius(5)
                            }
                            
                            Button(action: {
                                selectedOption = 2
                            }) {
                                HStack {
                                    Text("Verify with email address")
                                        .foregroundColor(selectedOption == 2 ? .white : .black)
                                    Spacer()
                                    Image(systemName: selectedOption == 2 ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(Color(0xFF016DB1))
                                }
                                .padding()
                                .background(selectedOption == 2 ? Color(0xFF016DB1) : Color.gray.opacity(0.1))
                                .cornerRadius(5)
                            }
                        
               }
               .frame(maxWidth: .infinity, minHeight: 50)
               .padding(16)
            
           Spacer()
            Button(action: { isVerifyModalShown1 = true }) {
                // 1
                Text("Send verification code")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .foregroundColor(.white) // 2
            .background(Color(0xFF016DB1))
            .cornerRadius(10) // 4
            .padding()
            .sheet(isPresented:
            $isVerifyModalShown1) {
                OtpModal()
            }
            
        }
        .padding(.top,16)
        
    }
}

struct VerifyAccountModal_Previews: PreviewProvider {
    static var previews: some View {
        VerifyAccountModal()
    }
}
struct RadioButtonToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() }) {
            HStack {
                configuration.label
                Spacer()
                Image(systemName: configuration.isOn ? "largecircle.fill.circle" : "circle")
            }
        }
    }
}





