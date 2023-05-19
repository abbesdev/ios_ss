//
//  QuizResponse.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 8/5/2023.
//

import Foundation

struct QuizResponse: Codable {
    let id: String
    let name: String
    let questions: [String]
    let classe: String
    let createdBy: String
    let submissions: [Submission]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case classe = "class"
        case name
        case questions
        case createdBy
        case submissions
    }
    
    struct Submission: Codable {
        let student: String
        let answers: [String]
        let grade: Double?
        
     
    }
}
