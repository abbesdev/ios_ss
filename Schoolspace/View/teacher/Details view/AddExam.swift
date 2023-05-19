//
//  AddExam.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 8/5/2023.
//

import SwiftUI
import Foundation
struct AddExam: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
       @State private var date = Date()
       @State private var startTime = Date()
       @State private var duration = 0
    @State private var selectedClassIndex = 0
    @State private var classes: [Classe] = [] // Array of Classe objects

       // Add any additional properties or dependencies you need, such as UserDefaults
       
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exam Details")) {
                    TextField("Name", text: $name)
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    
                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    
                    Stepper(value: $duration, in: 0...120, step: 15) {
                        Text("Duration: \(duration) minutes")
                    }
                }
                
                Section(header: Text("Class")) {
                    if !classes.isEmpty {
                        Picker("Class", selection: $selectedClassIndex) {
                            ForEach(classes.indices, id: \.self) { index in
                                Text(classes[index].name)
                            }
                        }
                       
                        .onChange(of: selectedClassIndex) { index in
                            print("Selected class: \(classes[index].name)")
                        }
                    }
                }
                
                Button(action: {
                    
                    print("clicked")
                    createExam()
                    
                }) {
                    Text("Create Exam")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("New Exam")
            .navigationBarItems(leading: Button(action: {
                       presentationMode.wrappedValue.dismiss()
                   }) {
                       Image(systemName: "chevron.left")
                           .imageScale(.large)
                           .padding(.vertical)
                   })

        }
            .onAppear(perform: fetchClasses)
        
       }
     func fetchClasses() {
        guard let teacherResponse = UserDefaults.standard.dictionary(forKey: "teacherResponse"),
              let teacherId = teacherResponse["_id"] as? String else {
            // Handle error when teacher ID is not available
            return
        }
           guard let url = URL(string: "https://backspace-gamma.vercel.app/class/teacher/\(teacherId)") else {
               // Handle invalid URL
               return
           }
           
           URLSession.shared.dataTask(with: url) { data, response, error in
               if let error = error {
                   // Handle error
                   print("Error: \(error.localizedDescription)")
                   return
               }
               
               if let data = data {
                   do {
                       let decoder = JSONDecoder()
                       classes = try decoder.decode([Classe].self, from: data)
                       print(classes)
                   } catch {
                       // Handle decoding error
                       print("Error decoding classes: \(error)")
                   }
               }
           }.resume()
       }
     func createExam() {
         print("entered func")
        guard let selectedClass = selectedClassIndex != nil ? classes[selectedClassIndex] : nil,
         let classId = selectedClass.id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    else { return }
   print(selectedClass)
   print(classId)
        
        guard let teacherResponse = UserDefaults.standard.dictionary(forKey: "teacherResponse"),
              let teacherId = teacherResponse["_id"] as? String else {
            // Handle error when teacher ID is not available
            return
        }
         print(teacherId)
         let isoDateFormatter = DateFormatter()
         isoDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Set the time zone to UTC

         // Format the date and start time using ISO 8601 format
         let dateString = isoDateFormatter.string(from: date)
         let startTimeString = isoDateFormatter.string(from: startTime)
        // Create the exam object
        let exam = Examm(
            name: name,
            date: dateString,
                startTime: startTimeString,
            duration: duration,
            classe: classId,
            createdBy: teacherId
        )
        print(exam)
        // Create the request URL
        guard let url = URL(string: "https://backspace-gamma.vercel.app/exam") else {
            // Handle error when the URL is invalid
            return
        }
         
        print(url)
        // Create the request body
        guard let examData = try? JSONEncoder().encode(exam) else {
            // Handle error when encoding the exam data fails
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = examData
        
        // Send the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle error when there's a network or request error
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Process the response
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // Exam creation was successful
                    print("Exam created successfully")
                    
                    // Optionally, you can show an alert or navigate back after successful exam creation
                } else {
                    // Exam creation failed with a non-200 status code
                    print("Failed to create exam. Status code: \(httpResponse.statusCode)")
                    
                    // Optionally, you can show an alert or handle the error accordingly
                }
            }
        }.resume()
    }

}
struct Examm: Codable {
    let name: String
    let date: String
    let startTime: String
    let duration: Int
    let classe: String
    let createdBy: String
    private enum CodingKeys: String, CodingKey {
        
        case name
        case date
        case startTime
        case duration
        case createdBy
        case classe = "class"
    }
}

struct AddExam_Previews: PreviewProvider {
    static var previews: some View {
        AddExam()
    }
}
