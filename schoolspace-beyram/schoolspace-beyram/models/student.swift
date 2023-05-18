//
//  student.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 7 on 30/4/2023.
//

import Foundation
struct User:Identifiable, Codable {
    let id = UUID()
    let _id : String
    let firstName: String
    let lastName: String
    
    let email: String
    let registrationCode: String
    let userRole: String
    let verified: Bool
    


    
}
/*
 {
       "_id": "6456661bd4701e8242f02c44",
       "lastName": "Ayadi",
       "phoneNumber": "123456789",
       "profilePhoto": "beyram.png",
       "email": "beyram@ayadi.com",
       "password": "123456",
       "registrationCode": "123456",
       "dateOfBirth": "2000-01-01T00:00:00.000Z",
       "userRole": "student",
       "verified": false,
       "__t": "Student",
       "createdAt": "2023-05-06T14:37:15.870Z",
       "updatedAt": "2023-05-06T14:37:15.870Z",
       "__v": 0
   },
 */
/*
let students = [
    User(_id : "123456",firstName: "Beyram", lastName: "Ayadi", email: "beyram.ayadi@esprit.tn" , userRole:"student",verified: true),
    User(_id : "123456",firstName: "Mohamed", lastName: "Abbes", email: "Mohamed.Abbes@esprit.tn" , userRole:"student",verified: true),
    User(_id : "123456",firstName: "Beyram", lastName: "Ayadi", email: "beyram.ayadi@esprit.tn" , userRole:"student",verified: false),
    User(_id : "123456",firstName: "Mohamed", lastName: "Abbes", email: "Mohamed.Abbes@esprit.tn" , userRole:"student",verified: false)


]
*/
