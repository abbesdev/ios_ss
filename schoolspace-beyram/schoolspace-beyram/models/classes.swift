//
//  classes.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 1 on 7/5/2023.
//

import Foundation

struct Classes: Hashable,Identifiable,Codable {
    let id = UUID()
    let _id: String
       let name: String
       let grade: String
       let section: String
       let teachers: [String]
       let __v: Int


   
}
