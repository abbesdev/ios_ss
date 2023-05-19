//
//  LoginViewModel.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import SwiftUI

// SignupViewModel follows the MVVM pattern
class SignupViewModel: ObservableObject {
    @Published var fullname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var redirectToLogin = false

    func registerUser(email: String, password:String, firstName:String, lastName:String, dateOfBirth:Date, registrationCode:String, phoneNumber:String, roleType:String, profilePhoto:String) {
        let url = URL(string: "https://backspace-gamma.vercel.app/users")!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // or any other format that MongoDB recognizes

        let dateOfBirthString = dateFormatter.string(from: dateOfBirth)
        let body = ["firstName": firstName,
                    "lastName": lastName,
                    "dateOfBirth": dateOfBirthString,
                    "phoneNumber": phoneNumber,
                    "registrationCode": registrationCode,
                    "email": email,
                    "password": password,
                    "userRole":roleType.lowercased(),
                    "profilePhoto":profilePhoto
        ] as [String : Any]
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
                 self.errorMessage = "Invalid credentials in register"
                 return
             }
             
             do {
                 let decoder = JSONDecoder()
                 let user = try decoder.decode(UserRegisterResponse.self, from: data)
                 // save user ID to shared preferences
                 UserDefaults.standard.set(user.id, forKey: "userID")
                 UserDefaults.standard.set(user.otp, forKey: "otp")

             } catch {
                 print("Error decoding user data: \(error)")
                 self.showError = true
                 self.errorMessage = "Error registering user"
             }
             
         }.resume()
    }
    func verifyUser() {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else {
            print("Error: No user ID in shared preferences")
            return
        }
        print(userID)
        print("trigger func")

        let url = URL(string: "https://backspace-gamma.vercel.app/\(userID)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT" // or "PATCH" depending on your backend implementation
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["verified": true]
        let bodyData = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Invalid response type")
                return
            }
            print(httpResponse.statusCode)
         
            DispatchQueue.main.async {
                   self.redirectToLogin = true
               }

            
            
            guard let data = data else {
                print("Error: No data in response")
                return
            }
        }.resume()
    }


}
