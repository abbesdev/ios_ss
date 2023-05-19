import SwiftUI

struct AddQuiz: View {
    @State private var quizName = ""
    @State private var selectedQuestions: Set<String> = []
    @State private var questions: [Question] = []

    var body: some View {
        VStack {
            TextField("Quiz Name", text: $quizName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

         
            List(questions, id: \._id) { question in
                MultipleSelectionRow(
                    text: question.text,
                    isSelected: selectedQuestions.contains(question._id)
                ) {
                    toggleQuestionSelection(question)
                }
            }

            Button(action: {
                createQuiz()
            }) {
                Text("Create Quiz")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear(perform : fetchQuestions)
    }

    func fetchQuestions() {
        // Create the request URL
        guard let url = URL(string: "https://backspace-gamma.vercel.app/question") else {
            // Handle invalid URL
            return
        }

        // Create the request
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // Handle error when there's a network or request error
                print("Error: \(error.localizedDescription)")
                return
            }

            // Process the response
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Question].self, from: data)
                    DispatchQueue.main.async {
                        questions = decodedData
                    }
                } catch {
                    // Handle error when decoding the response data fails
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    func toggleQuestionSelection(_ question: Question) {
        if selectedQuestions.contains(question._id) {
            selectedQuestions.remove(question._id)
        } else {
            selectedQuestions.insert(question._id)
        }
    }

    func createQuiz() {
        let selectedQuestionIds = selectedQuestions.map { $0 }
         let selectedQuestions = questions.filter { selectedQuestionIds.contains($0._id) }

        guard let teacherResponse = UserDefaults.standard.dictionary(forKey: "teacherResponse"),
              let teacherId = teacherResponse["_id"] as? String else {
            // Handle error when teacher ID is not available
            return
        }
        // Create the quiz object
        let quiz = Quiz(
            name: quizName,
            questions: selectedQuestions,
            classId: "644e54ba6dadf08348bf5df5", // Set the appropriate class ID value
            createdBy: teacherId // Set the appropriate creator ID value
        )

        // Create the request URL
        guard let url = URL(string: "https://backspace-gamma.vercel.app/quiz") else {
            // Handle invalid URL
            return
        }

        // Create the request body
        guard let quizData = try? JSONEncoder().encode(quiz) else {
            // Handle error when encoding the quiz data fails
            return
        }

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = quizData

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
                    // Quiz creation was successful
                    print("Quiz created successfully")

                    // Optionally, you can show an alert or navigate back after successful quiz creation
                } else {
                    // Quiz creation failed with a non-200 status code
                    print("Failed to create quiz. Status code: \(httpResponse.statusCode)")

                    // Optionally, you can show an alert or handle the error accordingly
                }
            }
        }.resume()
    }
}

struct MultipleSelectionRow: View {
    var text: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        HStack {
            Text(text)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
}
