//
//  AttendanceView.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 3/5/2023.
//

import SwiftUI


struct AttendanceView: View {

let selectedStudent: String // selected student id
@State private var selectedMonth:  Date = Date() // selected month in format "yyyy-MM"
@State private var attendanceRecords: [Attendance] = [] // retrieved attendance records

var body: some View {
    VStack (spacing:30){
       
        Text("Attendance records for your child").bold()
           
      
       
        
        Button("Get attendance records") {
            // call the backend API to retrieve attendance records for the selected student and month
            let url = URL(string: "https://backspace-gamma.vercel.app/attendance/\(selectedStudent)")!
            
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
                Text("Date of record: \(attendance.createdAt)")
            }
        }
    }.padding()
}
}


