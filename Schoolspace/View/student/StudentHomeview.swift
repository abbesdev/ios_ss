//
//  StudentHomeView.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import SwiftUI
struct StudentHomeView: View {
    @StateObject var viewModel = ViewModel()
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            Color.white // Set the background color of the ZStack to white
            NavigationView {
                VStack(alignment: .leading) {
                    Text("Welcome Back,")
                        .foregroundColor(Color(red: 0/255, green: 111/255, blue: 253/255))
                                   .font(.system(size: 14, weight: .medium))
                                   
                    if let userResponseDict = UserDefaults.standard.dictionary(forKey: "studentResponse"),
                       let firstName = userResponseDict["firstName"] as? String,
                       let lastName = userResponseDict["lastName"] as? String {
                           Text("\(firstName) \(lastName)")
                    }
                    
                           
                    SearchBar(text: $searchText)
                        
                    Text("Subjects")
                        .font(.system(size: 18, weight: .semibold))
                           .foregroundColor(.black)
                           
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.subjects, id: \._id) { subject in
                                SubjectBox(name: subject.nameSubject, imageUrl: subject.imageSubject.relativeString)
                            }
                        }
                        .padding(.vertical)
                        .padding(.horizontal,1)
                    }
                    
                    Text("Today's classes")
                        .font(.system(size: 18, weight: .semibold))
                           .foregroundColor(.black)
                           

                    ScrollView(.vertical) {
                        VStack (spacing: 100) {
                            ForEach(viewModel.timetables, id: \._id) { timetable in
                                TimeTableBox(name: timetable.title,
                                             startDate:timetable.startdate,
                                             endDate: timetable.enddate
                                )
                            }
                        }
                        .padding(.vertical)
                        .padding(.horizontal,1)

                    }
                  
                    .padding(.bottom, 10)
                    
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                
                .navigationBarItems(trailing:
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    }
                )
                .padding(.leading, 16)
                .padding(.trailing, 16)
            }
            
        }
       
    }
}





struct StudentHomeView_Previews: PreviewProvider {
    static var previews: some View {
        StudentHomeView()
    }
}
