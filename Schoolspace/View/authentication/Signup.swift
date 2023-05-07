//
//  Signup.swift
//  School space
//
//  Created by Mohamed Abbes on 15/3/2023.
//

import SwiftUI

struct Signup: View {
    @State  var givenEmail: String = ""
    @State  var givenPassword: String = ""
    @State  var givenFname: String = ""
    @State  var givenLname: String = ""

    @State private var showSheet = false
    @State var airplaneMode = true
    @State private var isOn = false
    @State private var isContinueModalShown = false

    @StateObject var viewModel = SignupViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 90) {
                Image("logoblue")
                VStack{
                    HStack{
                        VStack{
                            Text("First name").padding(.leading) .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.regular)
                            TextField(
                                "type in your first name",
                                text: $givenFname
                            )
                            .frame(height: 50)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(0xFFC5C6CC), lineWidth: 1.0)
                            )
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 6))
                        }
                        VStack{
                            Text("Last name").padding(.leading) .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.regular)
                            TextField(
                                "type in your last name",
                                text: $givenLname
                            )
                            .frame(height: 50)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(0xFFC5C6CC), lineWidth: 1.0)
                            )
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                        }
                    }
                    Text("Email Address").padding(.leading) .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.regular)
                    TextField(
                        "type in your email address",
                        text: $givenEmail
                    )
                    .frame(height: 50)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(0xFFC5C6CC), lineWidth: 1.0)
                    )
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    Text("Password").padding(.leading) .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.regular)
                    SecureField(
                        "type in your password",
                        text: $givenPassword
                    )
                    .frame(height: 48)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(0xFFC5C6CC), lineWidth: 1.0)
                    )
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    
                   
                    
                    Toggle(isOn: $isOn) {
                                Text("Accept our terms & conditions.")
                            }
                    .toggleStyle(iOSCheckboxToggleStyle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                }
                
               
                
                VStack (spacing: 10){
                    Button(action: {                        isContinueModalShown = true
 }) {
                      
                        Text("Create an account")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .foregroundColor(.white)
                    .background(Color(0xFF016DB1))
                    .cornerRadius(10)
                    .alert(isPresented: self.$viewModel.showError){
                        Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
                        
                    }
                    
                       .sheet(isPresented: $isContinueModalShown) {
                           SignupModal(givenFname: $givenFname, givenLname: $givenLname, givenEmail: $givenEmail, givenPassword:$givenPassword)
                       }
                   
                  
                    HStack(spacing: 0) {
                        Text("Already have an account ? ")
                            .foregroundColor(Color(0xFF000000))
                        NavigationLink(destination: Login()) {
                            Text("Login")
                                .foregroundColor(Color(0xFF016DB1))
                                .underline()
                                .bold()
                                }
                        .navigationBarBackButtonHidden(true)
                        .navigationViewStyle(StackNavigationViewStyle()) // optional, if you want to hide the navigation bar on the previous view

                        .navigationBarItems(leading: EmptyView()) // set the leading navigation bar item to be an empty view
                        
                    }}.padding()
            }
        }}
}


struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup()
    }
}
