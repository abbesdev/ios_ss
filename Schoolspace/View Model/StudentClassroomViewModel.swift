//
//  StudentHomeViewModel.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import SwiftUI

import Foundation

class ClassroomViewModel: ObservableObject {
    @Published var classrooms = [Classroom]()


    
    init() {
        fetchDataClassroom()
       

    }
    
   
    func fetchDataClassroom() {
        guard let url = URL(string: "https://project-android-sim.vercel.app/classroom/getAll") else {
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
                let decodedData = try JSONDecoder().decode([Classroom].self, from: data)
                DispatchQueue.main.async {
                    self.classrooms = decodedData
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
    func getUserById(_ id: String) {
        guard let url = URL(string: "https://project-android-sim.vercel.app/api/test/getuser\(id)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else {
                print("Invalid response")
                return
            }

            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)
                print("User: \(user)")
            } catch {
                print("Error decoding user: \(error.localizedDescription)")
            }
        }.resume()
    }

}

