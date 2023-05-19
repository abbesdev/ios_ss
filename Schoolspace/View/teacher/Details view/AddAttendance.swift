import SwiftUI

struct Student11: Codable, Identifiable {
    let id: String
    let identifiant: String
    let firstName: String
    let lastName: String
    // Add other properties from the response as needed
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case identifiant
        case firstName
        case lastName
        // Add other coding keys for additional properties
    }
}

struct AttendanceFormView: View {
    @State private var students: [Student11] = []
    @State private var selectedStudentId: String = ""
    @State private var isPresent: Bool = false
    @State private var isAbsent: Bool = false
    
    private func fetchStudents() {
        guard let url = URL(string: "https://backspace-gamma.vercel.app/students") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    students = try decoder.decode([Student11].self, from: data)
                } catch {
                    print("Error decoding students data: \(error)")
                }
            }
        }.resume()
    }
    
    private func submitAttendance() {
        guard let teacherResponse = UserDefaults.standard.dictionary(forKey: "teacherResponse"),
              let teacherId = teacherResponse["_id"] as? String else {
            // Handle error when teacher ID is not available
            return
        }
        guard let url = URL(string: "https://backspace-gamma.vercel.app/attendance") else {
            print("Invalid URL")
            return
        }
        
        let attendance = [
            "student": selectedStudentId,
            "teacher": teacherId,
            "subject": "default",
            "present": isPresent,
            "absent": isAbsent
        ] as [String : Any]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: attendance) else {
            print("Failed to serialize attendance data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
            }
        }.resume()
    }
    
    var body: some View {
        VStack (spacing:30){
            Picker("Select Student", selection: $selectedStudentId) {
                ForEach(students) { student in
                    Text("\(student.firstName) \(student.lastName)").tag(student.id)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectedStudentId) { _ in
                // Handle selection change if needed
            }
            Spacer()
            Toggle("Present", isOn: $isPresent)
            Toggle("Absent", isOn: $isAbsent)
            Spacer()
            Button(action: {
                
                print("clicked")
                submitAttendance()
                
            }) {
                Text("Validate Attendance")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear {
            fetchStudents() // Fetch students when the view appears
        }
    }
}

struct AttendanceFormView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceFormView()
    }
}
