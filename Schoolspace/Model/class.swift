//
//  class.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 7 on 2/5/2023.
//

import Foundation
struct Class1:Identifiable, Codable {
    let id = UUID()
    let classname: String

    let starttime: Date
    let endtime: Date

}


struct Event1: Codable,Identifiable {
   
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

struct Course1: Codable, Hashable {
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

struct Question1: Codable,Identifiable ,Equatable{
   
    let id: String
    let text: String
    let options: [String]
    let correctAnswer: String
    let __v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text
        case options
        case correctAnswer
        case __v
    }
}

struct Subject1: Codable, Hashable {
    let _id: String
    let name: String
    let description: String

  
}
struct Classes1: Hashable,Identifiable,Codable {
    let id = UUID()
    let _id: String
       let name: String
       let grade: String
       let section: String
       let teachers: [String]
       let __v: Int


   
}
struct Student1: Codable {
    
   
    let name: String
    let classname: String
    let profilePhoto : String
    

    


    
}
struct TimeSlot: Hashable {
    let startTime: Date
    let endTime: Date
    var isAvailable: Bool = true
}
struct UserCountsResponse: Codable {
    let counts: [Int]
}
