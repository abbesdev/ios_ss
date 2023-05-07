//
//  StudentClassroomView.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import SwiftUI

struct StudentClassroomView: View {
    @StateObject var viewModel = ClassroomViewModel()

    var body: some View {
        ZStack {
            Color.white // Set the background color of the ZStack to white
            NavigationView {
                VStack(alignment: .leading) {
                    
                    
                    
                    
                    ScrollView(.vertical) {
                        VStack {
                            ForEach(viewModel.classrooms, id: \.id) { classroom in
                                ClassroomBox(name: classroom.classroomTitle
                                )
                            }
                        }
                        .padding(.vertical)
                        .padding(.horizontal,16)
                    }
                    
                }
                .navigationTitle("Classroom")
                .navigationBarTitleDisplayMode(.inline)
                
                .navigationBarItems(trailing:
                                        NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                }
                )
                
            }
            
        }
        .padding(.horizontal)
    }
    }


struct StudentClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        StudentClassroomView()
    }
}
