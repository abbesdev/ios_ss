//
//  timetabledetails_view.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 7 on 2/5/2023.
//

import SwiftUI

struct timetabledetails_view: View {
    @State private var selectedOption = 0
        let options = ["2 éme 1", "2 éme 2", "2 éme 3"]
    let timeSlots = ["8:00","9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00"]
        @State private var selectedSubject = "Math"
        @State private var selectedClass = "Class A"
        @State private var selectedDate = Date()
    @State private var starttime = Date()
    @State private var endtime = Date()

    
    @State private var isShowingSheet = false
        @State private var input1 = ""
        @State private var input2 = ""
        @State private var input3 = ""
    @State var classOptions: [Classes] = []
    @State var subjectOptions: [Subject] = []


    @State var selectedClassId: String = ""
    @State var selectedSubjectId: String = ""

    

    var body: some View {
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
                Text("Time Tables Details")
                    .font(.system(size:15))
                    .foregroundColor(.black)
                    .bold()
                    .padding(.leading ,15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer(minLength: 5)
                Button(action: {
                    isShowingSheet = true
                }, label: {
                    Text("See Details")
                        .font(.system(size:20))
                        .underline()
                        .foregroundColor(Color(0xFF016DB1))
                        .bold()
                        .padding(.horizontal ,15)
                }).sheet(isPresented: $isShowingSheet) {
                    VStack(alignment: .leading, spacing: 10) {
                                   
                                 
                                    
                                    Text("Class")
                                        .font(.headline)
                        
                        
                        Picker(selection: $selectedClassId, label: Text("Select a class")) {
                            ForEach(classOptions, id: \._id) { classes in
                                Text(classes.name).tag(classes.id)
                            }
                        }
                        .onAppear(perform: getClasses)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(1))
                        .cornerRadius(8)
                        Text("Subject")
                            .font(.headline)
                        Picker(selection: $selectedSubjectId, label: Text("Select a subject")) {
                            ForEach(subjectOptions, id: \._id) { subjects in
                                Text(subjects.name).tag(subjects._id)
                            }
                        }
                        .onAppear(perform: getSubjects)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(1))
                        .cornerRadius(8)
                        
                        
                        
                        Text("Date")
                            .font(.headline)
                        
                   
                            DatePicker(selection: $selectedDate, displayedComponents: [.date], label: { Text("") })
                                .labelsHidden()
                                .onAppear(perform: getSubjects)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(1))
                                .cornerRadius(8)
                        Text("Start time")
                            .font(.headline)
                            DatePicker(selection: $starttime, displayedComponents: [.hourAndMinute], label: { Text("") })
                                .labelsHidden()
                                .onAppear(perform: getSubjects)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(1))
                                .cornerRadius(8)
                                
                        VStack{
                            Text("End time")
                                .font(.headline)
                                DatePicker(selection: $endtime, displayedComponents: [.hourAndMinute], label: { Text("") })
                                    .labelsHidden()
                                    .onAppear(perform: getSubjects)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray.opacity(1))
                                    .cornerRadius(8)
                        }
                            
                           
                     


                        

                                    Button("Add Class") {
                                        // Perform save action here
                                        addClass()
                                        isShowingSheet = false
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(0xFF016DB1))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                                .padding()
                    
                }
                
                
            }
            Text("Chose Class")
                .padding(.horizontal)
            
            VStack {
                
                Picker(selection: $selectedClassId, label: Text("Select a class")) {
                    ForEach(classOptions, id: \.id) { classes in
                        Text(classes.name).tag(classes.id)
                    }
                }
                .onAppear(perform: getClasses)
                
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
                .padding()
                
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                    
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                .pickerStyle(MenuPickerStyle())
                
            }
            HStack {
                Button(action: {
                    self.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: self.selectedDate) ?? Date()
                }) {
                    Image(systemName: "arrow.left")
                }
                Spacer()
                DatePicker(selection: $selectedDate, displayedComponents: [.date], label: { Text("") })
                    .labelsHidden()
                Spacer()
                Button(action: {
                    self.selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: self.selectedDate) ?? Date()
                }) {
                    Image(systemName: "arrow.right")
                }
            }.frame(maxWidth: .infinity)
            .padding(2)
            ScrollView {
                        VStack(spacing: 0) {
                            ForEach(timeSlots, id: \.self) { slot in
                                HStack {
                                    Text(slot)
                                        .frame(width: 50)
                                        .padding(.leading, 10)
                                    ZStack {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.2))
                                            .cornerRadius(8)
                                        Text("")
                                    }
                                    .frame(height: 50)
                                    .padding(.trailing, 10)
                                }
                            }
                        }
                    }
            
        }
        
    }
    func addClass() {
        // Construct the URL
        let url = URL(string: "http://172.17.7.17:8080/timetable")!

        // Construct the request body
        let body: [String: Any] = [
            "classId": selectedClassId,
            "startDate": formatDate(selectedDate, time: starttime),
            "endDate": formatDate(selectedDate, time: endtime),
            "timeDuration": 1,
            "subjectId": selectedSubjectId
        ]
        print(body)

        // Convert the body to JSON data
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])

        // Create the request object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        // Set the request headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Create the data task to send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }

        // Start the data task
        task.resume()
    }

    // Helper function to format date and time as ISO 8601 string
    func formatDate(_ date: Date, time: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        var combinedComponents = DateComponents()
        combinedComponents.year = components.year
        combinedComponents.month = components.month
        combinedComponents.day = components.day
        combinedComponents.hour  = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        combinedComponents.second = 0
        let combinedDate = calendar.date(from: combinedComponents)!
        return formatter.string(from: combinedDate)
    }

  
       
       
    func getClasses() {
        guard let url = URL(string: "http://172.17.7.17:8080/class") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Classes].self, from: data) {
                    DispatchQueue.main.async {
                        self.classOptions = decodedResponse
                    }
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    func getSubjects() {
        guard let url = URL(string: "http://172.17.7.17:8080/subject") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Subject].self, from: data) {
                    DispatchQueue.main.async {
                        self.subjectOptions = decodedResponse
                    }
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }


}

struct timetabledetails_view_Previews: PreviewProvider {
    static var previews: some View {
        timetabledetails_view()
    }
}
