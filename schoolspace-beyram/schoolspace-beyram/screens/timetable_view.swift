//
//  timetable_view.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 7 on 30/4/2023.
//

import SwiftUI

struct timetable_view: View {
    @State private var currentDate = Date()
    @State private var selectedDate: Date?
    private let calendar = Calendar.current
    @State var timetables: [Timetable] = []

    @StateObject var api = Api()


    var body: some View {
        
        NavigationView {

            VStack(alignment: .leading) {
                HStack{
                    Image("profile")
                    
                        .resizable()
                        .padding(.leading ,10)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                        
                        Text("Good Morning,")
                            .font(.system(size:20))
                            .foregroundColor(Color(0xFF016DB1))
                        
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Mr. Beyram")
                            .font(.system(size:20))
                            .bold()
                        
                        .frame(maxWidth: .infinity, alignment: .leading)}
                    
                    
                }
                HStack{
                    Text("Time Tables")
                        .font(.system(size:20))
                        .foregroundColor(.black)
                        .bold()
                        .padding(.leading ,15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer(minLength: 5)
                    
                    
                    
                    NavigationLink {
                        // destination view to navigation to
                        timetabledetails_view()
                    } label: {
                        Text("See Details")
                            .font(.system(size:20))
                            .underline()
                            .foregroundColor(Color(0xFF016DB1))
                            .bold()
                            .padding(.horizontal ,15)
                    }
                    
                    
                    
                }
                VStack {
                    HStack {
                        Button("<") {
                            currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
                        }
                        Spacer()
                        Text(calendar.component(.month, from: currentDate).monthName)
                            .font(.largeTitle)
                            .padding()
                        Spacer()
                        Button(">") {
                            currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                        }
                    }
                    .padding(.horizontal)
                    HStack(spacing: 0) {
                        ForEach((2...8), id: \.self) { i in
                            let dayIndex = (i % 7 == 0) ? 7 : i % 7
                            let day = calendar.shortWeekdaySymbols[dayIndex-1]
                            Text(day.prefix(1))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                        ForEach(getDaysInMonth(date: currentDate), id: \.self) { day in
                            let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth(for: currentDate)) ?? currentDate
                            Button(action: {
                              //  selectedDate = date
                                selectedDate = date
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "yyyy-MM-dd"
                                    let selectedDateString = formatter.string(from: selectedDate ?? Date())
                                print(selectedDateString)
                            }) {
                                Circle()
                                    .foregroundColor(getColor(day: day, date: date))
                                    .opacity(getOpacity(day: day, date: date))
                                    .frame(width: 40, height: 40)
                                    .overlay(Text(String(day)).foregroundColor(getTextColor(day: day, date: date)))
                            }
                        }
                    }
                    .padding()
                    ScrollView {
                        ForEach(timetables.filter { course in
                                   let formatter = DateFormatter()
                                   formatter.dateFormat = "yyyy-MM-dd"
                                   let dateString = formatter.string(from: selectedDate ?? Date())
                                   return course.startDate.prefix(10) == dateString
                               }, id: \.self) { course in
                                   let (date,time) = getDateAndTime(from: course.startDate)
                                   let (date2,time2) = getDateAndTime(from: course.endDate)
                                   singleitemcalendar_view(classname: course.classes, starttime: time, endtime: time2, subject: course.subject)
                               }

                       // move this line outside of the closure
}
                }
                
            }
            
        }.onAppear(perform: getTimetables)//getTimetables()
    }
    func getDateAndTime(from string: String) -> (String, String) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        guard let date = formatter.date(from: string) else { return ("", "") }
        formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        let dateString = formatter.string(from: date)
        formatter.formatOptions = [.withTime, .withColonSeparatorInTime]
        let timeString = formatter.string(from: date)
        
      
        
        return (dateString, timeString)
    }

    func getTimetables() {
        guard let url = URL(string: "http://\(api.baseurl):8080/timetablewithnames") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let timetables = try decoder.decode([Timetable].self, from: data)
                DispatchQueue.main.async {
                    self.timetables = timetables
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }

    /*
     func fetchData() {
           guard let url = URL(string: "http://localhost:8080/users") else { return }
           
           URLSession.shared.dataTask(with: url) { data, response, error in
               if let data = data {
                   if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                       DispatchQueue.main.async {
                           self.parents = decodedResponse
                       }
                       return
                   }
               }
               print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
           }.resume()
       }
     */

    func getDaysInMonth(date: Date) -> [Int] {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.map { $0 }
    }
    
    func startOfMonth(for date: Date) -> Date {
        return calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: date))) ?? date
    }
    
    func getColor(day: Int, date: Date) -> Color {
        if calendar.isDate(date, equalTo: selectedDate ?? Date(), toGranularity: .day) {
            return Color(0xFF016DB1)
        } else {
            return .clear
        }
    }
    
    func getOpacity(day: Int, date: Date) -> Double {
        if calendar.isDate(date, equalTo: selectedDate ?? Date(), toGranularity: .day) {
            return 1.0
        } else {
            return 0.3
        }
    }
    
    func getTextColor(day: Int, date: Date) -> Color {
        if calendar.isDate(date, equalTo: selectedDate ?? Date(), toGranularity: .day) {
            return .white
        } else {
            return .primary
        }
    }
}

struct timetable_view_Previews: PreviewProvider {
    static var previews: some View {
        timetable_view()
    }
}
