//
//  Exam.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 6/5/2023.
//

import Foundation

struct Exam: Codable, Identifiable {
    let id: String
    let name: String
    let date: String
    let startTime: String
    let duration: Int
    let classID: String
    let createdBy: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case date
        case startTime
        case duration
        case classID = "class"
        case createdBy
        case createdAt
        case updatedAt
    }
}

class ExamViewModel: ObservableObject {
    @Published var exams: [Exam] = []
    
    init() {
        guard let url = URL(string: "https://backspace-gamma.vercel.app/exam") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let exams = try JSONDecoder().decode([Exam].self, from: data)
                    DispatchQueue.main.async {
                        self.exams = exams
                        print(exams)
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}
