//
//  AttendanceView.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 3/5/2023.
//

import SwiftUI


struct AttendanceView: View {

@State private var selectedStudent: String = "644e592a536b22c1aaef85c8" // selected student id
@State private var selectedMonth:  Date = Date() // selected month in format "yyyy-MM"
@State private var attendanceRecords: [Attendance] = [] // retrieved attendance records

var body: some View {
    VStack {
        Picker("Select student", selection: $selectedStudent) {
            // populate the picker with the list of students (retrieve from backend API or use hardcoded values)
            Text("644e592a536b22c1aaef85c8").tag("644e592a536b22c1aaef85c8")
           
        }
        .pickerStyle(MenuPickerStyle())
        .padding()
        
        DatePicker("Select month", selection: $selectedMonth, displayedComponents: [.date])
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
        
        Button("Get attendance records") {
            // call the backend API to retrieve attendance records for the selected student and month
            let url = URL(string: "http://localhost:8080/attendance/\(selectedStudent)")!
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                if let decodedResponse = try? JSONDecoder().decode([Attendance].self, from: data) {
                    DispatchQueue.main.async {
                        self.attendanceRecords = decodedResponse
                    }
                    return
                }
            }.resume()
        }
        
        List(attendanceRecords, id: \.id) { attendance in
            VStack(alignment: .leading) {
                Text("Subject: \(attendance.subject)")
                Text("Present: \(attendance.present ? "Yes" : "No")")
                Text("Absent: \(attendance.absent ? "Yes" : "No")")
            }
        }
    }
}
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceView()
    }
}
