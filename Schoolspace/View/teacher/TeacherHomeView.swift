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
    @State private var modalExams = false
    @State private var modalChat = false
    var body: some View {
        
            NavigationView {
                VStack(alignment: .trailing) {
                    
                    Text("Class currently teaching").frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                  
                        HStack{
                            Text("4 SIM 2")
                                    .font(.subheadline)
                                    .padding(.leading, 4)
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
                                    //  modalAttendance = true
                                    
                                }
                                .sheet(isPresented: $modalAttendance) {
                                    // AttendanceView()
                                }
                            
                            Spacer()
                            Image("quiz")
                                .onTapGesture {
                                    modalQuiz = true
                                    
                                }
                                .sheet(isPresented: $modalQuiz) {
                                    
                                }
                            Spacer()
                            
                            Image("aaa")
                                .onTapGesture {
                                    modalChat = true
                                    
                                }
                                .sheet(isPresented: $modalChat) {
                                    // ChatList()
                                }
                            Spacer()
                            
                            Image("exam")
                            
                        }
                        
                    }
                    .padding()
                    .background(Color(0xFFFFFFFF))
                    .cornerRadius(10)
                    .frame(height: 150)
                    .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 4)
                    
                    
                    Text("Today's classes to teach").frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    
                    
                  
                    
                    
                    
                    
                
                   

                    
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
