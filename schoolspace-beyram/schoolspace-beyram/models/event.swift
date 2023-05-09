//
//  event.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 09/05/2023.
//

import Foundation

struct Event: Codable,Identifiable {
   
    let id: String
    let name: String
    let description: String
    let date: String
    let time: String
    let image: String
    let place: String
    let __v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case description
        case date
        case time
        case image
        case place
        case __v
    }
}

