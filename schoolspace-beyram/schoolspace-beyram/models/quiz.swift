//
//  quiz.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 08/05/2023.
//

import Foundation
struct Quiz: Codable, Identifiable {
    let id: String
    let name: String
    let questions: [String]
    let classID: String
    let createdBy: String
    let submissions: [Submission]
    let createdAt: String
    let updatedAt: String
    let __v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case questions
        case classID = "class"
        case createdBy
        case submissions
        case createdAt
        case updatedAt
        case __v
    }
}

struct Submission: Codable {
    let student: String
    let grade: Int?
    let id: String
    let answers: [String]
    
    enum CodingKeys: String, CodingKey {
        case student
        case grade
        case id = "_id"
        case answers
    }
}
/*
struct Answer: Codable {
    let question: String
    let answer: [String]
}
*/
