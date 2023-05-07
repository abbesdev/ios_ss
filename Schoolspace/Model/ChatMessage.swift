//
//  ChatMessage.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 7/5/2023.
//

import Foundation

struct ChatMessage: Identifiable, Encodable, Decodable {
    let id: String
    let sender: String
    let receiver: String
    let message: String
    let timestamp: String
    
    init(sender: String, receiver: String, message: String, timestamp : String) {
        self.id = "_id"
        self.sender = sender
        self.receiver = receiver
        self.message = message
        self.timestamp = timestamp
    }
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sender
        case receiver
        case message
        case timestamp

    }

}

