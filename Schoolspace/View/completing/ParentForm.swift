import SwiftUI

struct ParentForm: View {
    @State private var identifiant = ""
    @State private var selectedSubjectIndex = 0
    @State private var subjects: [StudentResponse] = []
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        VStack {
           

            if !subjects.isEmpty {
                Picker("Child Identifiant", selection: $selectedSubjectIndex) {
                    ForEach(subjects.indices, id: \.self) { index in
                        Text(subjects[index].identifiant)
                    }
                }
                .padding()
                .onChange(of: selectedSubjectIndex) { index in
                    print("Selected child: \(subjects[index].identifiant)")
                }
            }

            Button(action: {
            updateUser()
                viewModel.loggedInParent = true
            }) {
                Text("Submit")
            }
            .padding()
            .fullScreenCover(isPresented: self.$viewModel.loggedInParent){
                ParentMainView()
            }
        }
        .onAppear(perform: getAllSubjects)
    }

    func getAllSubjects() {
        guard let url = URL(string: "https://backspace-gamma.vercel.app/students") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }

            do {
                let subjects = try JSONDecoder().decode([StudentResponse].self, from: data)
                DispatchQueue.main.async {
                    self.subjects = subjects
                }
            } catch {
                print("Error decoding classes: \(error)")
            }
        }.resume()
    }

    func updateUser() {
        guard let defaults = UserDefaults.standard.dictionary(forKey: "parentResponse"),
               let userId = defaults["_id"] as? String,
              let selectedSubject = selectedSubjectIndex != nil ? subjects[selectedSubjectIndex] : nil,
              let subjectId = selectedSubject.id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
         else { return }
        print(selectedSubject)
        print(subjectId)
        print(userId)

        guard let url = URL(string: "https://backspace-gamma.vercel.app/users/parent/\(userId)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "child": [subjectId]
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            

            do {
                let response = try JSONDecoder().decode(ParentResponse.self, from: data)
                DispatchQueue.main.async {
                    
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }.resume()
    }
}
