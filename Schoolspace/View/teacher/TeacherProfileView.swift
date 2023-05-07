//
//  TeacherProfileView.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 7/5/2023.
//

import SwiftUI

struct TeacherProfileView: View {
    @State var firstName: String = "Mohamed"
    @State var lastName: String = "Abbes"
    @State var phoneNumber: String = "+216 90 000 000"
    @State var password: String = "***********"
    @State var isOn = false
    @State var isOn2 = false
    
    var body: some View {
        VStack {
            Image("person")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.vertical, 20)
            Text("\(firstName) \(lastName)").font(.headline)
            Text("Member since 2023").font(.subheadline)
                .padding(.bottom, 20)
            Form {
                Section(header: Text("App preferences").font(.subheadline)) {
                    
                    HStack{
                        Label("Online Status", systemImage: "hand.raised")
                            .foregroundColor(.black)
                            .offset(x: 0, y: 0)
                            .padding(.horizontal, 1)
                            .font(.subheadline)
                        Spacer()
                        Toggle("", isOn: $isOn)
                            .labelsHidden()
                        
                        
                        
                        
                    }
                    HStack{
                        Label("Alerts & Notifications", systemImage: "bolt")
                            .foregroundColor(.black)
                            .offset(x: 0, y: 0)
                            .padding(.horizontal, 1)
                            .font(.subheadline)
                        Spacer()
                        Toggle("", isOn: $isOn2)
                            .labelsHidden()

                       
                        
                        
                    }
                    
                    
                    
                }
                Section(header: Text("Profile preferences")) {
                   
                    HStack{
                        Label("First Name", systemImage: "person")
                            .foregroundColor(.black)
                            .font(.subheadline)

                            .offset(x: 0, y: 0)
                            .padding(.horizontal, 1)
                        TextField("First Name", text: $firstName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                        
                        
                        
                        
                    }
                    HStack{
                        Label("Last Name", systemImage: "person")
                            .foregroundColor(.black)
                            .font(.subheadline)

                            .offset(x: 0, y: 0)
                            .padding(.horizontal, 1)
                        TextField("First Name", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                        
                        
                        
                        
                    }
                    HStack{
                        Label("Phone Number", systemImage: "phone")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .offset(x: 0, y: 0)
                            .padding(.horizontal, 1)
                        
                        TextField("First Name", text: $phoneNumber)
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                            .padding(.horizontal, 2)
                        
                        
                        
                        
                    }
                    HStack{
                        Label("Password", systemImage: "lock")
                            .foregroundColor(.black)
                            .offset(x: 0, y: 0)
                            .font(.subheadline)

                            .padding(.horizontal, 1)
                        SecureField("First Name", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                        
                        
                        
                        
                    }
                    HStack{
                        Button( action: {
                           
                        }) {
                            HStack(alignment: .center){
                                Text("Update profile").frame(maxWidth: .infinity, alignment: .center)
                                    .font(.headline)
                                    
                            }
                    }
                
                        
                      
                    }
                  
                    .accentColor(Color(0xFF016DB1))
                   
                    
                    
                    
                }
                Section {
                    HStack{
                        Label("Change account", systemImage: "rectangle.portrait.and.arrow.forward")
                            .foregroundColor(.black)
                            .offset(x: 0, y: 0)
                            .padding(.horizontal, 1)
                            .font(.subheadline)

                        Spacer()
                        Button(action: {
                            // Delete user defaults
                            let domain = Bundle.main.bundleIdentifier!
                            UserDefaults.standard.removePersistentDomain(forName: domain)
                            UserDefaults.standard.synchronize()

                            // Redirect to login page
                            if let window = UIApplication.shared.windows.first {
                                window.rootViewController = UIHostingController(rootView: Login())
                                window.makeKeyAndVisible()
                            }
                        }) {
                            
                            Text("Logout")
                                .foregroundColor(.red)
                        }
                    }
                  
                }}
                
                .navigationTitle("PROFILE")
                .navigationBarTitleDisplayMode(.inline)
                
                .navigationBarItems(trailing:NavigationLink(destination: SettingsView())
                                    {
                    Image(systemName: "gear")
                }
                )
                
            }}
}

struct TeacherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherProfileView()
    }
}
