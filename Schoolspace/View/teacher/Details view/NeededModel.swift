//
//  NeededModel.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 18/5/2023.
//

import Foundation

class Question: Identifiable, Codable {
    var _id: String
    var text: String
    var options: [String]
    var correctAnswer: String
    
    init(_id: String, text: String, options: [String], correctAnswer: String) {
        self._id = _id
        self.text = text
        self.options = options
        self.correctAnswer = correctAnswer
    }
}

struct QuestionResponse: Codable {
    var text: String
    var options: [String]
    var correctAnswer: String
}

struct Quiz: Codable {
    let name: String
    let questions: [Question]
    let classId: String
    let createdBy: String

    
    enum CodingKeys: String, CodingKey {
        case name, questions, classId = "class", createdBy
    }
}
