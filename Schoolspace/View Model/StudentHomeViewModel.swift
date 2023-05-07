//
//  StudentHomeViewModel.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import SwiftUI

import Foundation

class ViewModel: ObservableObject {
    @Published var subjects = [Subject]()
    @Published var classes = [Classe]()
    @Published var timetables = [Timetable]()

    
    init() {
        fetchData()
        fetchDataClasses()
        fetchDataTimeTable()

    }
    
    func fetchData() {
        guard let url = URL(string: "https://project-android-sim.vercel.app/subject/getAll") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned from API")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Subject].self, from: data)
                DispatchQueue.main.async {
                    self.subjects = decodedData
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    func fetchDataClasses() {
        guard let url = URL(string: "https://project-android-sim.vercel.app/classes/getAll") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned from API")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Classe].self, from: data)
                DispatchQueue.main.async {
                    self.classes = decodedData
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    func fetchDataTimeTable() {
        guard let url = URL(string: "https://project-android-sim.vercel.app/timetable/getAll") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned from API")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Timetable].self, from: data)
                DispatchQueue.main.async {
                    self.timetables = decodedData
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
}

