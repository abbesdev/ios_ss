//
//  ExamView.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 8/5/2023.
//

import SwiftUI

struct ExamView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var quizzes: [Exam] = []
    @State var isAddQuizPresented = false // New state variable for showing AddQuiz view

    var body: some View {
        NavigationView {
            List(quizzes, id: \.id) { quiz in
                HStack {
                    Text(quiz.name)
                    Spacer()
                    Button(action: {
                                           deleteQuiz(id: quiz.id)
                                       }) {
                                           Image(systemName: "trash")
                                       }
                }
            }}
            .navigationTitle("Exams")
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Return")
                },
                trailing: Button(action: {
                    // Add quiz action here
                    isAddQuizPresented = true // Show AddQuiz view when button is tapped

                }) {
                    Text("Add Exam")
                }
            )
            .onAppear(perform: getQuizzes)
            .sheet(isPresented: $isAddQuizPresented) { // Present AddQuiz view when isAddQuizPresented is true
                           AddExam()
                       }
    }

    func getQuizzes() {
        if let teacherResponse = UserDefaults.standard.dictionary(forKey: "teacherResponse"),
           let teacherId = teacherResponse["_id"] as? String {
               // use the teacherId variable here
               print(teacherId)
       

        let apiUrl = "https://backspace-gamma.vercel.app/exam/teacher/\(teacherId)"
        guard let url = URL(string: apiUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                quizzes = try JSONDecoder().decode([Exam].self, from: data)
                print(quizzes)
            } catch {
                print(error)
            }
        }.resume()
        } else {
            // handle the case where the dictionary or the _id key is not found
        }
    }
    func deleteQuiz(id: String) {
          let apiUrl = "https://backspace-gamma.vercel.app/exam/\(id)"
          guard let url = URL(string: apiUrl) else { return }
          var request = URLRequest(url: url)
          request.httpMethod = "DELETE"
          
          URLSession.shared.dataTask(with: request) { data, response, error in
              if let error = error {
                  print(error)
              }
              // Remove the deleted quiz from the list
              quizzes.removeAll { $0.id == id }
          }.resume()
      }
}
