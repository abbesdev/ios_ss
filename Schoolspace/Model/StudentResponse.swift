//
//  StudentResponse.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 3/5/2023.
//

import Foundation

struct StudentResponse: Codable {
    let verified: Bool
    let id: String
    let identifiant: String
    let className: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let profilePhoto: String
    let email: String
    let password: String
    let registrationCode: String
    let dateOfBirth: String
    let userRole: String
    let subType: String
    let createdAt: String
    let updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case verified = "verified"
        case id = "_id"
        case identifiant = "identifiant"
        case className = "class"
        case firstName = "firstName"
        case lastName = "lastName"
        case phoneNumber = "phoneNumber"
        case profilePhoto = "profilePhoto"
        case email = "email"
        case password = "password"
        case registrationCode = "registrationCode"
        case dateOfBirth = "dateOfBirth"
        case userRole = "userRole"
        case subType = "__t"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case v = "__v"
    }
}
