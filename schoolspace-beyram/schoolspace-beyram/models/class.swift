//
//  class.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 7 on 2/5/2023.
//

import Foundation
struct Class:Identifiable, Codable {
    let id = UUID()
    let classname: String

    let starttime: Date
    let endtime: Date

}
let courses = [
    Class(classname: "Math", starttime: Date(), endtime: Date().addingTimeInterval(3600)),
    Class(classname: "Science", starttime: Date().addingTimeInterval(7200), endtime: Date().addingTimeInterval(10800)),
    Class(classname: "History", starttime: Date().addingTimeInterval(14400), endtime: Date().addingTimeInterval(18000))
]
