import SwiftUI

struct StudentForm: View {
    @State private var identifiant = ""
    @State private var selectedClassIndex = 0
    @State private var classes: [Classe] = []
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            TextField("Identifiant", text: $identifiant)
                .padding()

            if !classes.isEmpty {
                Picker("Class", selection: $selectedClassIndex) {
                    ForEach(classes.indices, id: \.self) { index in
                        Text(classes[index].name)
                    }
                }
                .padding()
                .onChange(of: selectedClassIndex) { index in
                    print("Selected class: \(classes[index].name)")
                }
            }

            Button(action: {
            updateUser()
                viewModel.loggedInStudent = true
            }) {
                Text("Submit")
            }
            .padding()
            .fullScreenCover(isPresented: self.$viewModel.loggedInStudent){
                student()
            }
        }
        .onAppear(perform: getAllClasses)
    }

    func getAllClasses() {
        guard let url = URL(string: "https://backspace-gamma.vercel.app/class") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }

            do {
                let classes = try JSONDecoder().decode([Classe].self, from: data)
                DispatchQueue.main.async {
                    self.classes = classes
                }
            } catch {
                print("Error decoding classes: \(error)")
            }
        }.resume()
    }

    func updateUser() {
        guard let defaults = UserDefaults.standard.dictionary(forKey: "studentResponse"),
               let userId = defaults["_id"] as? String,
              let selectedClass = selectedClassIndex != nil ? classes[selectedClassIndex] : nil,
              let classId = selectedClass.id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
         else { return }
        print(selectedClass)
        print(classId)
        print(userId)

        guard let url = URL(string: "https://backspace-gamma.vercel.app/users/student/\(userId)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "identifiant": identifiant,
            "class": classId
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
                let response = try JSONDecoder().decode(StudentResponse.self, from: data)
                DispatchQueue.main.async {
                    
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }.resume()
    }
}
