//
//  Classe.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import Foundation

struct Classe: Codable {
    let id: String
    let name: String
    let v: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case v = "__v"
    }
}
