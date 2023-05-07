//
//  ResetPasswordView.swift
//  School space
//
//  Created by Mohamed Abbes on 16/4/2023.
//

import SwiftUI

struct ResetPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email: String = ""
    @State private var showSuccessMessage: Bool = false
    @State private var showError: Bool = false
    
    var body: some View {
        VStack {
            Text("Email Address") .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.regular)
            TextField(
                "type in your email address",
                text: $email
            )
            .frame(height: 50)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(0xFFC5C6CC), lineWidth: 1.0)
            )
            
            Button("Reset Password") {
                resetPassword()
            }
           
                .frame(maxWidth: .infinity)
                .padding()
      
        .foregroundColor(.white)
        .background(Color(0xFF006FFD))
        .cornerRadius(10)
            
            if showSuccessMessage {
                Text("An email has been sent with instructions to reset your password")
                    .foregroundColor(.green)
            }
            
            if showError {
                Text("An error occurred. Please try again later.")
                    .foregroundColor(.red)
            }
            
        }
        .padding()
    }
    
    private func resetPassword() {
        let url = URL(string: "https://project-android-sim.vercel.app/reset-password")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body: [String: Any] = ["email": email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Invalid response type")
                return
            }
            print("Response status code: \(httpResponse.statusCode)")
            guard let data = data, error == nil else {
               
                return
            }
            
          
                
            if httpResponse.statusCode == 200  {
                    showSuccessMessage = true
                } else {
                    showError = true
                    
                }
          
        }.resume()
    }
}

struct ResetPasswordResponse: Codable {
    let success: Bool
}

