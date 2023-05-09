//
//  quizlistview.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 08/05/2023.
//

import SwiftUI

struct quizlistview: View {
    @State private var quizzes: [Quiz] = []
    var studentID = "645989cd3ec370d80cd86041"
//645989cd3ec370d80cd86041
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
            ScrollView{
                ForEach(quizzes, id: \.id) { quiz in
                    if let studentSubmission = quiz.submissions.first(where: { $0.student == studentID }) {
                        if let grade = studentSubmission.grade {
                            quizsingleitem(name: quiz.name, submitted: true)
                        } else {
                            quizsingleitem(name: quiz.name, submitted: false)
                            
                        }
                    }}
               /* List(quizzes) { quiz in
                    let i = quiz.submissions[0].grade
                    i.
                    if(quiz.submissions)
                        //        quizsingleitem(name: "Android", submitted: true)

                }*/
              
                
                
            }.onAppear {
                getQuizForStudent(studentID: studentID) { fetchedQuizzes, error in
                    if let fetchedQuizzes = fetchedQuizzes {
                        quizzes = fetchedQuizzes
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }.padding()
        
    }
    
    func getQuizForStudent(studentID: String, completion: @escaping ([Quiz]?, Error?) -> Void) {
        guard let url = URL(string: "http://172.17.7.17:8080/quizbystudent/\(studentID)") else {
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
                let quizzes = try JSONDecoder().decode([Quiz].self, from: data)
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
        quizlistview()
    }
}
