//
//  eventview.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 09/05/2023.
//

import SwiftUI

struct eventview: View {
    
    @State private var events: [Event] = []

    
    var body: some View {
        
        VStack{
            HStack{
                Text("Events").bold().font(.system(size: 40)).padding()

Spacer()
            }
            /*
             ScrollView{
                 ForEach(quizzes, id: \.id) { quiz in
                     if let studentSubmission = quiz.submissions.first(where: { $0.student == studentID }) {
                      
                         if let grade = studentSubmission.grade {
                      
                             
                             quizmarkitem(name: quiz.name, mark: grade)
                         }
                     }}
             }
             */
            
            ScrollView {
                ForEach(events, id: \.id) { event in
                    eventitem(name: event.name, date: formatDate(date: event.date), time: event.time)
                    //formatDate(date: event.date)
                }
            }
            .onAppear {
                getAllEvents() { fetchedEvents, error in
                    if let fetchedEvents = fetchedEvents {
                        events = fetchedEvents
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

            
        }
     }
    
    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date2 = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date2)
        } else{
            return "err"
        }
    }
    
    
    func getAllEvents(completion: @escaping ([Event]?, Error?) -> Void) {
        guard let url = URL(string: "http://172.17.7.17:8080/event") else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(nil, error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                completion(nil, error)
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    print("here")
                   

                    let events = try JSONDecoder().decode([Event].self, from: data)
                    completion(events, nil)
                    /*
                     let quizzes = try JSONDecoder().decode([Quiz].self, from: data)
                     completion(quizzes, nil)
                     */
                } catch let error {
                    print("ta7che")

                    completion(nil, error)
                }
            } else {
                let error = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
                completion(nil, error)
            }
        }
        
        task.resume()
    }

    
    
}

struct eventview_Previews: PreviewProvider {
    static var previews: some View {
        eventview()
    }
}
