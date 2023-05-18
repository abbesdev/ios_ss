//
//  clesses2.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 1 on 7/5/2023.
//
import Foundation
struct Course: Codable, Hashable {
    let id: String
    let classId: String
    let startDate: Date
    let endDate: Date
    let timeDuration: Int
    let subject: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case classId = "class"
        case startDate
        case endDate
        case timeDuration
        case subject
    }
}
