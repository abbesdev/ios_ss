//
//  StudentMainView.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import SwiftUI

struct StudentMainView: View {
    // View model instance
    @StateObject var viewModel = StudentMainViewModel()
    
    var body: some View {
        TabView {
                   StudentHomeView()
                       .tabItem {
                           Label("Home", systemImage: "house")
                       }
                   StudentClassroomView()
                       .tabItem {
                           Label("Classroom", systemImage: "book.closed")
                       }
                   StudentReportView()
                       .tabItem {
                           Label("Timetable", systemImage: "calendar")
                       }
                   StudentProfileView()
                       .tabItem {
                           Label("Profile", systemImage: "person")
                       }
            
               }
               .navigationBarTitleDisplayMode(.inline)
               .accentColor(.blue)

    }
}

struct StudentMainView_Previews: PreviewProvider {
    static var previews: some View {
        StudentMainView()
    }
}

// ContentViewModel follows the MVVM pattern
class StudentMainViewModel: ObservableObject {
    // Observable properties here
}






