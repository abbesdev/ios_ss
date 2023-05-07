//
//  Login.swift
//  School space
//
//  Created by Mohamed Abbes on 15/3/2023.
//

import SwiftUI

struct Login: View {
    @State private var givenEmail: String = ""
    @State private var givenPassword: String = ""
    @State var isPresenting = false /// 1.
    @State var airplaneMode = true
    @State private var isResetPasswordModalShown = false

    @StateObject var viewModel = LoginViewModel()
    @State private var isOn = false
    @State private var willMoveToNextScreen = false
    var body: some View {
        NavigationView { /// 2.
            VStack(spacing: 90) {
                Image("logoblue")
                VStack{
                    
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
                    
                    HStack(spacing: 0) {
                        Text("Forgot password ? ")
                            .foregroundColor(Color(0xFF000000))
                        
                        Text("Reset here")
                            .foregroundColor(Color(0xFF016DB1))
                            .underline()
                            .onTapGesture {
                                isResetPasswordModalShown = true
                               }.sheet(isPresented: $isResetPasswordModalShown) {
                                   ResetPasswordView()
                               }
                            
                        
                        
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                    
                    Toggle(isOn: $isOn) {
                                Text("Remember me")
                            }
                    .toggleStyle(iOSCheckboxToggleStyle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                }
                
               
                
                VStack (spacing: 10){
                    Button(action: {viewModel.loginUser(email : givenEmail, password :givenPassword) }) {
                      
                        Text("Sign in")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .foregroundColor(.white)
                    .background(Color(0xFF016DB1))
                    .cornerRadius(10)
                    .alert(isPresented: self.$viewModel.showError){
                        Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
                        
                    }
                    .fullScreenCover(isPresented: self.$viewModel.loggedInParent){
                        ParentMainView()
                    }
                    .fullScreenCover(isPresented: self.$viewModel.loggedInStudent){
                        StudentMainView()
                    }
                    .fullScreenCover(isPresented: self.$viewModel.loggedInTeacher){
                        TeacherMainView()
                    }
                    
                  
                    HStack(spacing: 0) {
                        Text("Don't have an account ? ")
                            .foregroundColor(Color(0xFF000000))
                        NavigationLink(destination: Signup()) {
                            Text("Sign up")
                                .foregroundColor(Color(0xFF016DB1))
                                .underline()
                                .bold()
                                }.navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading: EmptyView()) // set the leading navigation bar item to be an empty view
                            .navigationViewStyle(StackNavigationViewStyle()) // optional, if you want to hide the navigation bar on the previous view

                    }}.padding()
            }
            
                 
        
        }
        .onAppear {
                       let defaults = UserDefaults.standard
                       if let email = defaults.string(forKey: "email"),
                          let password = defaults.string(forKey: "password") {
                           givenEmail = email
                           givenPassword = password
                           viewModel.loginUser(email: email, password: password)
                       }
                   }
    }
}
extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        // 1
        Button(action: {

            // 2
            configuration.isOn.toggle()

        }, label: {
            HStack {
                // 3
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")

                configuration.label
            }
        })
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}






