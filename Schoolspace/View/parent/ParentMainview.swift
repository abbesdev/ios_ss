//
//  ParentMainView.swift
//  School space
//
//  Created by Mohamed Abbes on 25/4/2023.
//

import SwiftUI

struct ParentMainView: View {
    var body: some View {
        TabView {
                   ParentHomeView()
                       .tabItem {
                           Label("Overview", systemImage: "house")
                       }
                   ParentTimetableView()
                       .tabItem {
                           Label("Timetable", systemImage: "calendar")
                       }
                   ParentProfileView()
                       .tabItem {
                           Label("Profile", systemImage: "person")
                       }
                  
            
               }
               .navigationBarTitleDisplayMode(.inline)
               .accentColor(Color(0xFF016DB1))
    }
}

struct ParentMainView_Previews: PreviewProvider {
    static var previews: some View {
        ParentMainView()
    }
}
