import SwiftUI

struct AddQuestionView: View {
    @Binding var isPresented: Bool
    @State private var questionText = ""
    @State private var options: [String] = []
    @State private var correctAnswer = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Question")) {
                    TextField("Question Text", text: $questionText)
                }
                Section(header: Text("Options")) {
                    ForEach(options.indices, id: \.self) { index in
                        TextField("Option \(index + 1)", text: $options[index])
                    }
                    Button(action: {
                        options.append("")
                    }) {
                        Label("Add Option", systemImage: "plus.circle")
                    }
                }
                Section(header: Text("Correct Answer")) {
                    TextField("Correct Answer", text: $correctAnswer)
                }
            }
            .navigationTitle("Add Question")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveQuestion()
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func saveQuestion() {
        // Create the question object
        let newQuestion = QuestionResponse(
            text: questionText,
            options: options,
            correctAnswer: correctAnswer
        )
        
        // Create the request URL
        guard let url = URL(string: "https://backspace-gamma.vercel.app/question") else {
            // Handle invalid URL
            return
        }
        
        // Create the request body
        guard let questionData = try? JSONEncoder().encode(newQuestion) else {
            // Handle error when encoding the question data fails
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = questionData
        
        // Send the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle error when there's a network or request error
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Process the response
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 201 {
                    // Question creation was successful
                    print("Question created successfully")
                    
                    // Optionally, you can show an alert or perform any necessary action
                    
                    // Dismiss the sheet
                    isPresented = false
                } else {
                    // Question creation failed with a non-200 status code
                    print("Failed to create question. Status code: \(httpResponse.statusCode)")
                    
                    // Optionally, you can show an alert or handle the error accordingly
                }
            }
        }.resume()
    }
}
