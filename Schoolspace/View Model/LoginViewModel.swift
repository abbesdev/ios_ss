//
//  LoginViewModel.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import SwiftUI

// LoginViewModel follows the MVVM pattern
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var loggedInStudent = false
    @Published var loggedInParent = false
    @Published var loggedInTeacher = false
    @Published var loggedInAdmin = false

    @Published var loggedInNotStudent = false
    @Published var loggedInNotParent = false
    @Published var loggedInNotTeacher = false
    
    func loginUser(email: String, password: String) {
        let url = URL(string: "https://backspace-gamma.vercel.app/login")!
        let body = ["email": email, "password": password]
        let bodyData = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Invalid response type")
                return
            }
            print("Response status code: \(httpResponse.statusCode)")

            guard let data = data else {
                print("Error: No data in response")
                self.showError = true
                self.errorMessage = "Invalid credentials in login"
                return
            }

            if httpResponse.statusCode == 200 {
                do {
                    let response = try JSONDecoder().decode(UserResponse.self, from: data)
                    DispatchQueue.main.async {
                       

                        switch response.userRole {
                        case "student":
                            do {
                                let studentResponse = try JSONDecoder().decode(StudentResponse.self, from: data)
                                // Handle student response
                                
                                if(studentResponse.className == "6458f81487f6465601a9bae0"){
                                    self.loggedInNotStudent = true

                                }
                                else
                                {
                                    self.loggedInStudent = true
                                }
                                let defaults = UserDefaults.standard
                                let responseDict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                                       defaults.set(responseDict, forKey: "studentResponse")
                            } catch {
                                print("Error decoding student response: \(error)")
                                self.showError = true
                                self.errorMessage = "Invalid response from server"
                            }
                        case "parent":
                            do {
                                let parentResponse = try JSONDecoder().decode(ParentResponse.self, from: data)
                                // Handle parent response
                                if(parentResponse.child.first == nil){
                                    self.loggedInNotParent = true

                                }
                                else
                                {
                                    self.loggedInParent = true
                                }
                                let defaults = UserDefaults.standard
                                // Convert the UserResponse to a dictionary and save it to UserDefaults
                                let responseDict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                                       defaults.set(responseDict, forKey: "parentResponse")
                                       
                            } catch {
                                print("Error decoding parent response: \(error)")
                                self.showError = true
                                self.errorMessage = "Invalid response from server"
                            }
                        case "teacher":
                            do {
                                let teacherResponse = try JSONDecoder().decode(TeacherResponse.self, from: data)
                                if(teacherResponse.subject == "6458f81487f6465601a9bae0"){
                                    self.loggedInNotTeacher = true

                                }
                                else
                                {
                                    self.loggedInTeacher = true
                                }
                                let defaults = UserDefaults.standard
                                let responseDict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                                       defaults.set(responseDict, forKey: "teacherResponse")
                                // Handle teacher response
                            } catch {
                                print("Error decoding teacher response: \(error)")
                                self.showError = true
                                self.errorMessage = "Invalid response from server"
                            }
                        case "admin":
                            do {
                             
                               
                               
                                    self.loggedInAdmin = true
                                
                            
                            } catch {
                                print("Error decoding teacher response: \(error)")
                                self.showError = true
                                self.errorMessage = "Invalid response from server"
                            }
                        default:
                            print("Invalid user role")
                        }
                    }
                } catch {
                    print("Error decoding response: \(error)")
                    self.showError = true
                    self.errorMessage = "Invalid response from server"
                }
            } else {
                print("Error response status code: \(httpResponse.statusCode)")
                self.showError = true
                self.errorMessage = "Incorrect email or password"
            }
        }.resume()
    }

}
