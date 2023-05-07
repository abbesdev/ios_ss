//
//  TeacherMainView.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 7/5/2023.
//

import SwiftUI

struct TeacherMainView: View {
    var body: some View {
        TabView {
                   TeacherHomeView()
                       .tabItem {
                           Label("Overview", systemImage: "house")
                       }
                 
                   TeacherProfileView()
                       .tabItem {
                           Label("Profile", systemImage: "person")
                       }
                  
            
               }
               .navigationBarTitleDisplayMode(.inline)
               .accentColor(Color(0xFF016DB1))
    }
}

struct TeacherMainView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherMainView()
    }
}
