//
//  EventDetailsView.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 6/5/2023.
//

import SwiftUI
import URLImage

struct ExamDetailsView: View {
    let examId: String
    
    @StateObject private var viewModel = ExamDetailsViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            if let exam = viewModel.exam {
                ExamDetailsHeader(exam: exam)
                ExamDetailsBody(exam: exam)
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchExamDetails(examId: examId)
                    }
            }
        }
        .padding()
        .sheet(isPresented: $viewModel.showSheet) {
         
        }
    }
}

struct ExamDetailsHeader: View {
    let exam: Exam
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
           
            Text(exam.name)
                .font(.largeTitle)
                .fontWeight(.bold)
           
        }
    }
}

struct ExamDetailsBody: View {
    let exam: Exam
    @StateObject private var viewModel = ExamDetailsViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Description Section
           
                Section {
                    Text("Teacher responsible")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)

                    Text(exam.createdBy)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(6)
                }

                Divider()

                // Location Section
                Section {
                    Text("Date of Exam")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)

                    Text(exam.date)
                        .foregroundColor(.secondary)
                }

                Divider()

                // Organizer Section
                Section {
                    Text("Time duration")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)
                    Text(exam.startTime)
                        .foregroundColor(.secondary)
                }

               
            }
            .padding(.horizontal)
        }
    }
}

class ExamDetailsViewModel: ObservableObject {
    @Published var exam: Exam?
    @Published var showSheet = false
    
    func fetchExamDetails(examId: String) {
        let urlString = "http://localhost:8080/exam/examId/\(examId)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching exam details: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let examResponse = try JSONDecoder().decode(Exam.self, from: data)
                DispatchQueue.main.async {
                    self.exam = examResponse
                }
            } catch {
                print("Error decoding exam details: \(error.localizedDescription)")
            }
        }.resume()
    }
}

