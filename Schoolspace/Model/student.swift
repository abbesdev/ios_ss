//
//  student.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 7 on 30/4/2023.
//

import Foundation
struct User1:Identifiable, Codable {
    let id = UUID()
    let _id : String
    let firstName: String
    let lastName: String
    
    let email: String
    let registrationCode: String
    let userRole: String
    let verified: Bool
    


    
}

