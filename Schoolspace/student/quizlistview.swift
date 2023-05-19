//
//  quizlistview.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 08/05/2023.
//

import SwiftUI

struct quizlistview: View {
    @State private var quizzes: [Quiz1] = []
    var studentID: String
  //  var studentID = "645989cd3ec370d80cd86041"
//645989cd3ec370d80cd86041
    struct IndexIdentifiable: Identifiable {
      let id: Int
    }
    @StateObject var api = Api()
    @State private var navigateToQuizView: IndexIdentifiable?

    var body: some View {
        
        VStack{
            HStack{
                Text("Quizzes").bold().font(.system(size: 40)).padding()

Spacer()
            }
           

            // Use the quizzes array to display the data
          /*  ForEach(quizzes, id: \.id) { quiz in
                Text(quiz.name)
                List(quizzes) { quiz in
                    if let studentSubmission = quiz.submissions.first(where: { $0.student == "6459258898a49052220bffdd" }) {
                        
                        if let grade = studentSubmission.grade {
                            Text("Grade: \(grade)")
                        } else {
                            Text("Quiz not yet graded.")
                        }
                    } else {
                        Text("Student did not submit this quiz.")
                    }
                }
            }*/
            ScrollView {
              ForEach(Array(quizzes.enumerated()), id: \.element.id) { index, quiz in
                Button(action: {
                  navigateToQuizView = IndexIdentifiable(id: index)
                }) {
                  quizsingleitem(name: quiz.name, submitted: false)
                }
                .fullScreenCover(item: $navigateToQuizView) { indexIdentifiable in
                  let quiz = quizzes[indexIdentifiable.id]
                  quizview(quizId: quiz.id, quizname: quiz.name, studentID: studentID)
                }
              }
            }
.onAppear {
                getQuizForStudent(studentID: "6466847ab4b53d0afbb6fd35") { fetchedQuizzes, error in
                    if let fetchedQuizzes = fetchedQuizzes {
                        quizzes = fetchedQuizzes
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }.padding()
        
    }
   
    
    func getQuizForStudent(studentID: String, completion: @escaping ([Quiz1]?, Error?) -> Void) {
        
        guard let studentResponse = UserDefaults.standard.dictionary(forKey: "studentResponse"),
              let classId = studentResponse["class"] as? String else {
            // Handle error when teacher ID is not available
            return
        }
        guard let url = URL(string: "\(api.baseurl)/quiz/class/\(classId)") else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data returned", code: -1, userInfo: nil))
                return
            }
            
            do {
                let quizzes = try JSONDecoder().decode([Quiz1].self, from: data)
                completion(quizzes, nil)
                print(quizzes)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    

}

struct quizlistview_Previews: PreviewProvider {
    static var previews: some View {
        quizlistview(studentID: "6466847ab4b53d0afbb6fd35")
    }
}
