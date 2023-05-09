//
//  timetable.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 11 on 6/5/2023.
//


import Foundation

struct Timetable: Hashable,Identifiable,Codable {
    let id = UUID()
    let startDate: String
    let endDate: String
    let timeDuration: Int

    let classes: String
    let subject: String



   
}
/*
 {
        "startDate": "2023-05-06T00:00:00.000Z",
        "endDate": "2023-05-06T00:00:00.000Z",
        "timeDuration": 1,
        "classes": "4 sim 1",
        "subject": "ios"
    }
 */


/*
 {
         "_id": "6456907d00deb8d0baa09ec3",
         "class": "645685dbd4701e8242f02ceb",
         "startDate": "2023-05-06T00:00:00.000Z",
         "endDate": "2023-05-06T00:00:00.000Z",
         "timeDuration": 1,
         "subject": "645684f6d4701e8242f02ce1",
         "__v": 0
     }
 */
