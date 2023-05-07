//
//  Message.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 7/5/2023.
//

import Foundation
struct Message: Codable {
    let id: String
    let message: String
    let sender: String
    let receiver: String
    let timestamp: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case message
        case sender
        case receiver
        case timestamp
        case v = "__v"
    }
}

