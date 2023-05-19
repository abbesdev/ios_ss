import Foundation

class ParentHomeViewModel: ObservableObject  {
    @Published var user: StudentResponse? // add this property to the view model
    @Published var classe: Classe? // add this property to the view model

    // MARK: - Properties
    
    private let baseURL = "https://backspace-gamma.vercel.app"
    
    // MARK: - Functions
    
    func getUserById(id: String) {
        let url = URL(string: "https://backspace-gamma.vercel.app/users/\(id)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(StudentResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.user = decodedResponse // update the user property
                    }
                    return
                }
            }

            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    func getClasseById(id: String) {
        let url = URL(string: "https://backspace-gamma.vercel.app/class/\(id)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Classe.self, from: data) {
                    DispatchQueue.main.async {
                        self.classe = decodedResponse // update the user property
                    }
                    return
                }
            }

            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }

    
}
