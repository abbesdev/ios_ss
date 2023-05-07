//
//  ParentResponse.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 3/5/2023.
//

import Foundation

struct ParentResponse: Codable {
    let id: String
    let child: [String]
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
    let t: String
    let createdAt: String
    let updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case child
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
        case t = "__t"
        case createdAt
        case updatedAt
        case v = "__v"
    }
}
