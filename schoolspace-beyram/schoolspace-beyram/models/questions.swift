//
//  questions.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 17/05/2023.
//

import Foundation

struct Question: Codable,Identifiable ,Equatable{
   
    let id: String
    let text: String
    let options: [String]
    let __v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text
        case options
        case __v
    }
}

