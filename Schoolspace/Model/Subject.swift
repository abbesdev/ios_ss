//
//  Subject.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import Foundation
struct Subject: Codable {
    let _id: String
    let nameSubject: String
    let imageSubject: URL
    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case nameSubject = "nameSubject"
        case imageSubject = "imageSubject"
    }
}



