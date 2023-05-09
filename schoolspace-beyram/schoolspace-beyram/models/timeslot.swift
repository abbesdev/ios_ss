//
//  timeslot.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 1 on 7/5/2023.
//

import Foundation
struct TimeSlot: Hashable {
    let startTime: Date
    let endTime: Date
    var isAvailable: Bool = true
}
