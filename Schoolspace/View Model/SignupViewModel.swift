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
    
    func registerUser(email: String,  password:String, firstName:String,lastName:String, dateOfBirth:Date, registrationCode:String, phoneNumber:String, roleType:String, profilePhoto:String) {
        let url = URL(string: "http://localhost:8080/users")!
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
             
           
         }.resume()
    }
}
