//
//  TeacherHomeView.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 7/5/2023.
//

import SwiftUI

struct TeacherHomeView: View {
    @State private var modalAttendance = false
    @State private var modalQuiz = false
    @State private var modalExam = false
    @State private var modalChat = false
    @ObservedObject var viewModelEvent = EventViewModel()
    @State private var isShowingDetails = false
    @State private var isShowingDetails2 = false
    @State private var selectedEventId: String?
    var body: some View {
        
            NavigationView {
                VStack(alignment: .trailing) {
                    
                    Text("Subject currently teaching").frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)

                        HStack{
                            if let teacherResponse = UserDefaults.standard.dictionary(forKey: "teacherResponse"),
                               let subject = teacherResponse["subject"] as? String {
                                
                                Text("Subject id :\(subject)")
                                    .font(.subheadline)
                                    .padding(.leading, 4)
                            }else {
                                Text("Physics")
                                    .font(.subheadline)
                                    .padding(.leading, 4)
                            }
                                Spacer()

                               

                           
                               }
                        .padding()
                        .padding(.vertical,5)
                        .background(Color(0xFFDDF0FC))
                        .cornerRadius(10)
                        .frame(width: 360,height: 80)
                    
                    
                    //ACADEMICS
                    VStack (spacing: 20){
                        
                        
                        Text("Academics").frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(alignment: .center, spacing: 0){
                            Image("bbb")
                                .onTapGesture {
                                     modalAttendance = true
                                    
                                }
                                .sheet(isPresented: $modalAttendance) {
                                     AttendanceFormView()
                                }
                            
                            Spacer()
                            Image("quiz")
                                .onTapGesture {
                                    modalQuiz = true
                                    
                                }
                                .fullScreenCover(isPresented: $modalQuiz) {
                                    NavigationView {
                                        QuizView()
                                           
                                    }
                                }

                            Spacer()
                            
                            Image("aaa")
                                .onTapGesture {
                                    modalChat = true
                                    
                                }
                                .sheet(isPresented: $modalChat) {
                                     ChatListparent()
                                }
                            Spacer()
                            
                            Image("exam")
                                .onTapGesture {
                                    modalExam = true
                                    
                                }
                                .fullScreenCover(isPresented: $modalExam) {
                                    NavigationView {
                                        ExamView()
                                           
                                    }
                                }
                            
                        }
                        
                    }
                    .padding()
                    .background(Color(0xFFFFFFFF))
                    .cornerRadius(10)
                    .frame(height: 150)
                    .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 4)
                    
                    
                    Text("Upcoming events").frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModelEvent.events, id: \.id) { event in
                                Button(action: {
                                    selectedEventId = event.id
                                    self.isShowingDetails.toggle()
                                }) {
                                    EventBox(name: event.name,
                                             image: event.image,
                                             description: event.description)
                                }
                                
                            }
                        }
                    }
                    .sheet(isPresented: $isShowingDetails) {
                        
                        if let eventId = selectedEventId {
                               EventDetailsView(eventId: eventId)
                           }
                        
                    }
                    VStack{
                        Spacer()
                    }
                    

                    
                  
                    
                    
                    
                    
                
                   

                    
                }
                .navigationTitle("OVERVIEW")
                .navigationBarTitleDisplayMode(.inline)
                
                .navigationBarItems(trailing:
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    }
                )
                .padding(.leading, 16)
                .padding(.trailing, 16)
            }
            
        
}}


struct TeacherHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherHomeView()
    }
}
