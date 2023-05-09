//
//  performanceview.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 09/05/2023.
//

import SwiftUI

struct performanceview: View {
  //  var progress: Double = 0.7
    @State private var progress = 0.0
    @State private var progresspercentage = 0.0
    @State private var quizzes: [Quiz] = []
    var studentID = "6459258898a49052220bffdd"
    var totalGrade = 0
    var total_test = 0
//645989cd3ec370d80cd86041
    //6459258898a49052220bffdd
   // for quiz in qu
    
   

    
    
    
    var body: some View {
    
        
        VStack{
            HStack{
                Text("Quizzes").bold().font(.system(size: 40)).padding()

Spacer()
            }.padding(20)
            VStack (spacing:0){
                HStack {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Mohamed Abbes")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("4 SIM 1")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                    }
                    Spacer()
                    Image("profile")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                }.padding()
                HStack{
                    Text("Overall performance")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text(String(format: "%.2f",progresspercentage)+"%")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    
                }.padding()
                HStack{
                    ProgressView(value: progress)
                        .frame(width: 320, height: 3)
                        .accentColor(.white)
                    
                }.onAppear {
                    getQuizForStudent(studentID: studentID) { fetchedQuizzes, error in
                        if let fetchedQuizzes = fetchedQuizzes {
                            quizzes = fetchedQuizzes

                            // Calculate the total grade and update the progress view
                            var totalGrade = 0
                            for quiz in quizzes {
                                if let submission = quiz.submissions.first(where: { $0.student == studentID }), let grade = submission.grade {
                                    totalGrade += grade
                                }
                            }
                            let maxGrade = quizzes.count * 20
                            progress = Double(totalGrade) / Double(maxGrade)
                            progresspercentage = Double(totalGrade) / Double(maxGrade) * 100
                           
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }.padding()

                
            }
        
        .background(Color(0xFF016DB1))                            .cornerRadius(10)
   

        .frame(height: 130)
            
            
            
            
            HStack{
                Text("Quiz grades").font(.system(size: 20)).padding()

Spacer()
            }.padding(20)
            
            
            
            
            ScrollView{
                ForEach(quizzes, id: \.id) { quiz in
                    if let studentSubmission = quiz.submissions.first(where: { $0.student == studentID }) {
                     
                        if let grade = studentSubmission.grade {
                     
                            
                            quizmarkitem(name: quiz.name, mark: grade)
                        } 
                    }}
               
              
                
                
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

struct performanceview_Previews: PreviewProvider {
    static var previews: some View {
        performanceview()
    }
}
