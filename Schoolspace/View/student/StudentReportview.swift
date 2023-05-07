//
//  StudentProfileView.swift
//  School space
//
//  Created by Mohamed Abbes on 12/4/2023.
//

import SwiftUI
struct StudentReportView: View {
    @State private var selectedDate: Date = Date()
    @State private var timetables: [Timetable] = []
    private let calendar = Calendar.current
    private let weekStartDay = 2 // 1 = Sunday, 2 = Monday, etc.
    let formatter = DateFormatter()

    func fetchDataTimeTable(for date: Date) {
        // Format the date string in the expected format by the API
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDateString = dateFormatter.string(from: startOfWeek(for: date))
        let endDateString = dateFormatter.string(from: endOfWeek(for: date))

        guard let url = URL(string: "https://project-android-sim.vercel.app/timetable/getAll?startdate=\(startDateString)&enddate=\(endDateString)") else {
            fatalError("Invalid URL")
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data returned from API")
                return
            }

            do {
                let decodedData = try JSONDecoder().decode([Timetable].self, from: data)
                DispatchQueue.main.async {
                    self.timetables = decodedData
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }

    func startOfWeek(for date: Date) -> Date {
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        components.weekday = weekStartDay
        return calendar.date(from: components)!
    }

    func endOfWeek(for date: Date) -> Date {
        let components = DateComponents(day: 6, hour: 23, minute: 59, second: 59)
        return calendar.date(byAdding: components, to: startOfWeek(for: date))!
    }
    func formatDate(date: Date) -> String {
           let formatter = DateFormatter()
        formatter.dateFormat = "d\nE"
           return formatter.string(from: date)
       }

    var body: some View {
        NavigationView {
        
        VStack {
            HStack(spacing: 10) {
                ForEach(0..<5) { i in
                    let date = calendar.date(byAdding: .day, value: i, to: startOfWeek(for: selectedDate))!
               

                    Text(formatDate(date: date))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .padding()
                        .frame(width: 65, height:90)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.accentColor)
                                .opacity(selectedDate == date ? 1 : 0.5)
                        )
                        .onTapGesture {
                            selectedDate = date
                        }
                }
            }

            Button("Fetch Timetable") {
                fetchDataTimeTable(for: selectedDate)
            }
            .padding()

            // Display fetched data
            if !timetables.isEmpty {
                ScrollView(.vertical) {
                    VStack (spacing: 100) {
                ForEach(timetables, id: \._id) { timetable in
                    TimeTableBox(name: timetable.title,
                                 startDate:timetable.startdate,
                                 endDate: timetable.enddate
                    )
                }
                    }
                    .padding(.vertical)
                    .padding(.horizontal,1)

                }
            }
        }
        .navigationTitle("Timetable")
        .navigationBarTitleDisplayMode(.inline)
        
        .navigationBarItems(trailing:
                                NavigationLink(destination: SettingsView()) {
            Image(systemName: "gear")
        }
        )
    }

    }
}
