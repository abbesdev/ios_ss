import SwiftUI

struct TeacherForm: View {
    @State private var identifiant = ""
    @State private var selectedSubjectIndex = 0
    @State private var subjects: [SubjectNew] = []
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        VStack {
           

            if !subjects.isEmpty {
                Picker("Class", selection: $selectedSubjectIndex) {
                    ForEach(subjects.indices, id: \.self) { index in
                        Text(subjects[index].name)
                    }
                }
                .padding()
                .onChange(of: selectedSubjectIndex) { index in
                    print("Selected subject: \(subjects[index].name)")
                }
            }

            Button(action: {
            updateUser()
                viewModel.loggedInTeacher = true
            }) {
                Text("Submit")
            }
            .padding()
            .fullScreenCover(isPresented: self.$viewModel.loggedInTeacher){
                TeacherMainView()
            }
        }
        .onAppear(perform: getAllSubjects)
    }

    func getAllSubjects() {
        guard let url = URL(string: "https://backspace-gamma.vercel.app/subject") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }

            do {
                let subjects = try JSONDecoder().decode([SubjectNew].self, from: data)
                DispatchQueue.main.async {
                    self.subjects = subjects
                }
            } catch {
                print("Error decoding classes: \(error)")
            }
        }.resume()
    }

    func updateUser() {
        guard let defaults = UserDefaults.standard.dictionary(forKey: "teacherResponse"),
               let userId = defaults["_id"] as? String,
              let selectedSubject = selectedSubjectIndex != nil ? subjects[selectedSubjectIndex] : nil,
              let subjectId = selectedSubject.id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
         else { return }
        print(selectedSubject)
        print(subjectId)
        print(userId)

        guard let url = URL(string: "https://backspace-gamma.vercel.app/users/teacher/\(userId)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "subject": subjectId
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
                let response = try JSONDecoder().decode(TeacherResponse.self, from: data)
                DispatchQueue.main.async {
                    
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }.resume()
    }
}
