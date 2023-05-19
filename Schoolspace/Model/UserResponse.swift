// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userResponse = try? JSONDecoder().decode(UserResponse.self, from: jsonData)

import Foundation

struct UserResponse: Codable {
    let id: String
    let verified: Bool
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let userRole: String // Add this property
    
    enum CodingKeys: String, CodingKey {
        case verified = "verified"
        case id = "_id"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case password = "password"
        case userRole
    }
    
}


