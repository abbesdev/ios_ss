//
//  ParentProfileView.swift
//  School space
//
//  Created by Mohamed Abbes on 25/4/2023.
//
import URLImage

import SwiftUI

struct ParentProfileView: View {
    @State var firstName: String = "Mohamed"
    @State var lastName: String = "Abbes"
    @State var phoneNumber: String = "+216 90 000 000"
    @State var password: String = "***********"
    @State var isOn = false
    @State var isOn2 = false
    @ObservedObject var viewModelHome = ParentHomeViewModel()

    var body: some View {
        
        VStack {
            
            if let parentResponse = UserDefaults.standard.dictionary(forKey: "parentResponse"),
               let profilePhoto = parentResponse["profilePhoto"] as? String {
                AsyncImage(url: URL(string: profilePhoto)) { image in
                    image.resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                } placeholder: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 80, height: 80)
            }

        
            if let parentResponse = UserDefaults.standard.dictionary(forKey: "parentResponse"),
               let firstName = parentResponse["firstName"] as? String,
               let lastName = parentResponse["lastName"] as? String
            {
                Text("\(firstName) \(lastName)")
            }
            
            else
        
            {
               Text("No name fetched")
            }
            if let parentResponse = UserDefaults.standard.dictionary(forKey: "parentResponse"),
               let createdAt = parentResponse["createdAt"] as? String {
                
                let dateParts = createdAt.components(separatedBy: "T")
                if dateParts.count > 0 {
                    let date = dateParts[0]
                    Text("Member since \(date)").font(.subheadline)
                        .padding(.bottom, 20)
                } else {
                    Text("Member since 2023").font(.subheadline)
                        .padding(.bottom, 20)
                }
            } else {
                Text("Member since 2023").font(.subheadline)
                    .padding(.bottom, 20)
            }

            
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
                   
                    HStack {
                        Label("First Name", systemImage: "person")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .offset(x: 0, y: 0)
                            .padding(.horizontal, 1)
                        
                        if let parentResponse = UserDefaults.standard.dictionary(forKey: "parentResponse"),
                           let firstName = parentResponse["firstName"] as? String {
                            
                            TextField("First Name", text: Binding(get: {
                                firstName
                            }, set: { value in
                                // You may want to update the parentResponse dictionary with the new value here
                            }))
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                            
                        } else {
                            TextField("First Name", text: $firstName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                        }
                    }

                    HStack {
                        Label("Last Name", systemImage: "person")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .offset(x: 0, y: 0)
                            .padding(.horizontal, 1)
                        
                        if let parentResponse = UserDefaults.standard.dictionary(forKey: "parentResponse"),
                           let lastName = parentResponse["lastName"] as? String {
                            
                            TextField("Last Name", text: Binding(get: {
                                lastName
                            }, set: { value in
                                // You may want to update the parentResponse dictionary with the new value here
                            }))
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                            
                        } else {
                            TextField("Last Name", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                        }
                    }

                    HStack {
                        Label("Phone number", systemImage: "person")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .offset(x: 0, y: 0)
                            .padding(.horizontal, 1)
                        
                        if let parentResponse = UserDefaults.standard.dictionary(forKey: "parentResponse"),
                           let phoneNumber = parentResponse["phoneNumber"] as? String {
                            
                            TextField("Phone number", text: Binding(get: {
                                phoneNumber
                            }, set: { value in
                                // You may want to update the parentResponse dictionary with the new value here
                            }))
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                            
                        } else {
                            TextField("Phone number", text: $phoneNumber)
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                        }
                    }
                    HStack {
                        Label("Password", systemImage: "person")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .offset(x: 0, y: 0)
                            .padding(.horizontal, 1)
                        
                        if let parentResponse = UserDefaults.standard.dictionary(forKey: "parentResponse"),
                           let password = parentResponse["password"] as? String {
                            
                            SecureField("Password", text: Binding(get: {
                                password
                            }, set: { value in
                                // You may want to update the parentResponse dictionary with the new value here
                            }))
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                            
                        } else {
                            TextField("Password", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                        }
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
                
            }
        
    }
}

struct ParentProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ParentProfileView()
    }
}
