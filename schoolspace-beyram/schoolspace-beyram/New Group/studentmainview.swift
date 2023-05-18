//
//  studentmainview.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 08/05/2023.
//
import SwiftUI

struct student: View {
    @State private var selection = 0
    @StateObject var api = Api()
    var studentID = "645989cd3ec370d80cd86041"
   // var student : [Student]
//6459258898a49052220bffdd
//645989cd3ec370d80cd86041
    var body: some View {
        TabView(selection: $selection) {
            studenthomeview(studentID: studentID)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(0)
                    
            timetable_view()
                   .tabItem {
                       Image(systemName: "calendar")
                       Text("Timetable")
                   }
                   .tag(1)
                   
            timetable_view()
                   .tabItem {
                       Image(systemName: "person.crop.circle")
                       Text("Profile")
                   }
                   .tag(2)
           
                    
           
        }.navigationBarHidden(true)
                .accentColor(Color(0xFF016DB1))
                .onChange(of: selection) { value in
                    switch value {
                    case 1:
                        // Show the ParentsView when "Parents" tab is selected
                        // You can replace this with your own view
                        print("Showing ParentsView")
                    case 2:
                        // Show the StudentsView when "Students" tab is selected
                        // You can replace this with your own view
                        print("Showing StudentsView")
                    case 3:
                        // Show the TeachersView when "Teachers" tab is selected
                        // You can replace this with your own view
                        print("Showing TeachersView")
                    case 4:
                        // Show the CalendarView when "Calendar" tab is selected
                        // You can replace this with your own view
                        print("Showing CalendarView")
                    default:
                        // Show the default view when the first tab or any unrecognized tab is selected
                        // You can replace this with your own view
                        print("Showing default view")
                    }
                }
        
        
        
        
    }
   
    
    
}

struct student_Previews: PreviewProvider {
    static var previews: some View {
        student()
    }
}
