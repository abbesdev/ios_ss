//
//  quizview.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 15/05/2023.
//

import SwiftUI

struct quizview: View {
    @State private var selectedAnswer = ""
 //   @State private var selectedAnswers = [String]()
    //var quizId = "64598a1d3ec370d80cd8604a"
    var quizId : String
    var quizname : String
    var studentID : String
    
    @State private var questions: [Question] = []
   @State private var answer: [String] = []
    @State var selectedAnswers: [String] = []
    @StateObject var api = Api()

    var questionindex = 0
    @State var isQuizSubmitted = false
    @State var timeRemaining = 70
    @State var timetostart = 5

    @State var showConfirmationAlert = false
    @State var isRedText = false
    @State var isPresentingDetailView = false

    @State private var showView1 = false
    
    @State private var showtest = false



    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        
        
        VStack {
            if self.showtest == false {
                Text("The quiz will start in  \(timetostart) ").font(.system(size: 35)).bold().onReceive(timer2) { _ in
                    if timetostart > 0 {
                        timetostart -= 1
                        // isRedText.toggle()
                    } else {
                        self.showtest = true
                        
                        
                    }
                }
            } else
            if self.showtest == true{
                NavigationStack {
                    
                    
                    
                    VStack{
                        HStack{
                            Text(quizname).bold().font(.system(size: 40)).padding()
                            
                            Spacer()
                        }
                        Text("Time Remaining: \(timeRemaining / 60) minutes \(timeRemaining % 60) seconds")
                            .font(.headline)
                            .padding()
                            .foregroundColor(isRedText && timeRemaining < 60 ? .red : .black)
                        
                        
                        ScrollView {
                            ForEach(questions) { question in
                                QuizItem(question: question.text, answers: question.options, selectedAnswer: Binding(
                                    get: {
                                        // Retrieve selected answer from the array
                                        let index = questions.firstIndex(of: question) ?? 0
                                        if index < selectedAnswers.count {
                                            return selectedAnswers[index]
                                        } else {
                                            return "" // Default value if answer not yet selected
                                        }
                                    },
                                    set: { newAnswer in
                                        // Update selected answer in the array
                                        let index = questions.firstIndex(of: question) ?? 0
                                        if index < selectedAnswers.count {
                                            selectedAnswers[index] = newAnswer
                                        } else {
                                            selectedAnswers.append(newAnswer)
                                        }
                                    }
                                ))
                            }
                            Button("Submit Quiz") {
                                showConfirmationAlert = true
                                
                                //submitQuiz()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isQuizSubmitted ? Color.gray : Color(0xFF016DB1))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .disabled(isQuizSubmitted)
                            
                            
                            Button("Print Selected Answers") {
                                print(selectedAnswers)
                            }
                        }.onAppear {
                            getQuestions(quizId: quizId) { fetchedQuizzes, error in
                                if let fetchedQuizzes = fetchedQuizzes {
                                    questions = fetchedQuizzes
                                    
                                    
                                } else if let error = error {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }.onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                            isRedText.toggle()
                        } else {
                            submitQuiz()
                            
                        }
                    }.alert(isPresented: $showConfirmationAlert) {
                        Alert(
                            title: Text("Confirmation"),
                            message: Text("Do you want to submit?"),
                            primaryButton: .default(Text("Yes")) {
                                print("here2")
                                
                                submitQuiz()
                                
                            },
                            secondaryButton: .cancel(Text("No"))
                        )
                    } .navigationDestination(isPresented: $showView1) {
                        student()
                    }
                    
                }
            }
        }
      /**************/
    }
    func submitQuiz() {
        timer.upstream.connect().cancel()
           isQuizSubmitted = true
        print(isQuizSubmitted)
           // Perform any additional actions upon submitting the quiz
           print("Quiz Submitted")
           print(selectedAnswers)
        print("before")
        

        let url = URL(string: "http://\(api.baseurl):8080/quiz/\(quizId)/\(studentID)")!
        print("quizid")
        print(quizId)

        // Construct the request body
        let body: [String: Any] = [
            
            "answers" : selectedAnswers
         
        ]
        print(body)

        // Convert the body to JSON data
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])

        // Create the request object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        // Set the request headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Create the data task to send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }

        // Start the data task
        task.resume()
        
        
        
        
        
        self.showView1.toggle()

        print("before2")
        

        
        
       }
    
   /* func getQuestions(quizId: String) async throws -> [Question] {
        let url = URL(string: "http://172.17.3.33:8080/questionsbyquiz/\(quizId)")!
        let (data, response) = try await URLSession.shared.dataTask(with: url)
        let questions = try JSONDecoder().decode([Question].self, from: data)
        return questions
    }*/
    
    
    func getQuestions(quizId: String, completion: @escaping ([Question]?, Error?) -> Void) {
        guard let url = URL(string: "http://\(api.baseurl):8080/questionsbyquiz/\(quizId)") else {
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
                let questions = try JSONDecoder().decode([Question].self, from: data)
                completion(questions, nil)
                print(questions)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }



}

struct quizview_Previews: PreviewProvider {
    static var previews: some View {
        quizview(quizId: "64598a1d3ec370d80cd8604a" , quizname: "placeholder", studentID: "fsf")
    }
}
