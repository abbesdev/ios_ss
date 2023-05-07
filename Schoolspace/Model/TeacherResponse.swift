//
//  TeacherResponse.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 3/5/2023.
//

import Foundation


struct TeacherResponse: Decodable {
    let verified: Bool
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
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case verified
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
        case createdAt
        case updatedAt
    }
    
  
}
