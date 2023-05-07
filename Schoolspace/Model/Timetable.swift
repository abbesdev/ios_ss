//
//  TimeTable.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import Foundation

struct Timetable: Codable {
    let _id: String
    let title: String
    let classes: [String]
    let startdate: String
    let enddate: String
    let v: Int
    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case title = "title"
        case classes
        case startdate
        case enddate
        case v = "__v"
    }
}
