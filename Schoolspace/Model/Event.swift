//
//  Event.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 3/5/2023.
//

import Foundation
import SwiftUI

struct Event: Codable {
    let id: String
    let name: String
    let description: String
    let date: String
    let time: String
    let image: String
    let place: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case description
        case date
        case time
        case image
        case place
    }
}

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    init() {
        guard let url = URL(string: "https://backspace-gamma.vercel.app/event") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let events = try JSONDecoder().decode([Event].self, from: data)
                    DispatchQueue.main.async {
                        self.events = events
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}
