//
//  Classroom.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import Foundation

struct Classroom: Codable, Identifiable {
    let id: String
    let classroomTitle: String
    let classes: [String]
    let students: [String]
    let teacher: [String]
    let subject: [String]
    let homework: [String]
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case classroomTitle
        case classes
        case students
        case teacher
        case subject
        case homework
        case v = "__v"
    }
}
