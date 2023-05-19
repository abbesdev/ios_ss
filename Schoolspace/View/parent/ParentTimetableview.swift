//
//  ParentTimetableView.swift
//  School space
//
//  Created by Mohamed Abbes on 25/4/2023.
//

import SwiftUI

struct ParentTimetableView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.white // Set the background color of the ZStack to white
            NavigationView {
                
                VStack {
                    Text("Today's Timetable").font(.headline).bold().foregroundColor(Color(0xFF016DB1)).padding(.top,10)
                    ScrollView(.vertical) {
                        VStack (spacing: 100) {
                            ForEach(viewModel.timetables, id: \.id) { timetable in
                                VStack{
                                    HStack{
                                        Text(timetable.subject)
                                            .font(.title2).frame(maxWidth: .infinity, alignment: .leading)
                                       
                                        
                                    }
                                    HStack{
                                        Text(timetable.startDate).font(.subheadline)
                                        Text(timetable.endDate).font(.subheadline)
                                        
                                    }
                                }
                                
                                
                            }
                        }
                        .padding(.vertical)
                        
                        .padding(.horizontal,16)
                        
                    }}
                
                
                .navigationTitle("TIMETABLE")
                .navigationBarTitleDisplayMode(.inline)
                
                .navigationBarItems(trailing:NavigationLink(destination: SettingsView())
                                    {
                    Image(systemName: "gear")
                }
                )
               
            }
        }
        }
        
    }

struct ParentTimetableView_Previews: PreviewProvider {
    static var previews: some View {
        ParentTimetableView()
    }
}
