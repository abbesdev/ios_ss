//
//  StudentProfileView.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import SwiftUI

struct StudentProfileView: View {
    @ObservedObject var viewModel = StudentProfileViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading, spacing: 20) {
                  
                    HStack {
                        Text("Online Status")
                        Spacer()
                        Toggle("", isOn: $viewModel.isOnline)
                            .onChange(of: viewModel.isOnline) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "isOnline")
                            }

                       
                    }
                    Divider()
                    HStack {
                        Text("Notifications & alerts")
                        Spacer()
                        Toggle("", isOn: $viewModel.receiveNotifications)
                            .onChange(of: viewModel.receiveNotifications) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "receiveNotifications")
                            }
                    }
                    Divider()
                    HStack {
                           Text("First name:")
                           Spacer()
                           TextField("First name", text: $viewModel.firstName)
                               .frame(width: 200)
                       }
                       HStack {
                           Text("Last name:")
                           Spacer()
                           TextField("Last name", text: $viewModel.lastName)
                               .frame(width: 200)
                       }
                       HStack {
                           Text("Phone number:")
                           Spacer()
                           TextField("Phone number", text: $viewModel.phoneNumber)
                               .frame(width: 200)
                       }
                       HStack {
                           Text("Password:")
                           Spacer()
                           SecureField("Password", text: $viewModel.password)
                               .frame(width: 200)
                       }
                    Divider()
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
                        HStack {
                            Spacer()
                            Text("Logout")
                            Image(systemName: "arrow.right.square")
                        }
                    }
                }
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                Spacer()
            }
            .onAppear {
                            // Set default values from UserDefaults
                            let defaults = UserDefaults.standard
                            viewModel.firstName = defaults.string(forKey: "firstName") ?? ""
                            viewModel.lastName = defaults.string(forKey: "lastName") ?? ""
                            viewModel.phoneNumber = defaults.string(forKey: "phoneNumber") ?? "Phone number not added yet"
                            viewModel.password = defaults.string(forKey: "password") ?? ""
                            viewModel.isOnline = defaults.bool(forKey: "isOnline")
                            viewModel.receiveNotifications = defaults.bool(forKey: "receiveNotifications")
                        }
            
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            
            .navigationBarItems(trailing:
                                    NavigationLink(destination: SettingsView()) {
                Image(systemName: "gear")
            }
            )
        }
        
    }
    
}

class StudentProfileViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phoneNumber = ""
    @Published var password = ""
    @Published var isOnline = false
    @Published var receiveNotifications = false
}

