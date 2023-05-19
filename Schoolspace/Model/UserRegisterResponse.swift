//
//  UserRegisterResponse.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 8/5/2023.
//

import Foundation

struct UserRegisterResponse: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let profilePhoto: String
    let email: String
    let password: String
    let registrationCode: String
    let dateOfBirth: String
    let userRole: String
    let verified: Bool
    let otp: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
}

extension UserRegisterResponse {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName
        case lastName
        case phoneNumber
        case profilePhoto
        case email
        case password
        case registrationCode
        case dateOfBirth
        case userRole
        case verified
        case otp
        case createdAt
        case updatedAt
        case __v
    }
}
