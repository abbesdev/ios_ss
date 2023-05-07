//
//  ParentHomeView.swift
//  School space
//
//  Created by Mohamed Abbes on 25/4/2023.
//
import URLImage

import SwiftUI


struct ParentHomeView: View {
    @State private var modalAttendance = false
    @State private var feeAttendance = false
    @State private var askTeacher = false
    @ObservedObject var viewModelEvent = EventViewModel()
    @State private var isShowingDetails = false
    @State private var isShowingDetails2 = false
    @State private var selectedEventId: String?
    @State private var selectedExamId: String?
    @ObservedObject var viewModelExam = ExamViewModel()
    @ObservedObject var viewModelHome = ParentHomeViewModel()

    var body: some View {
        ZStack {
            Color.white // Set the background color of the ZStack to white
            NavigationView {
                VStack(alignment: .center) {
                    VStack (spacing:20){
                               HStack {
                                 
                                   VStack(alignment: .leading, spacing: 5) {
                                       if let parentResponse = UserDefaults.standard.dictionary(forKey: "parentResponse"),
                                          let child = parentResponse["child"] as? [String],
                                          let childName = child.first {
                                           
                                         
                                           
                                           if let user = viewModelHome.user {
                                               Text("\(user.firstName) \(user.lastName)")
                                                   .font(.headline)
                                                   .foregroundColor(.white)
                                               if let classe = viewModelHome.classe {
                                                   Text("\(classe.name)")
                                                       .font(.headline)
                                                       .foregroundColor(.white)
                                               } else {
                                                   Text("Loading...")
                                                       .font(.subheadline)
                                                       .foregroundColor(.white)
                                                       .onAppear {
                                                           viewModelHome.getClasseById(id: user.className)
                                                       }
                                               }
                                           } else {
                                               Text("Loading...")
                                                   .font(.subheadline)
                                                   .foregroundColor(.white)
                                                   .onAppear {
                                                       viewModelHome.getUserById(id: childName)
                                                   }
                                           }
                                         
                                           
                                       }
                                       
                                      
                                   }
                                   Spacer()
                                   if let parentResponse = UserDefaults.standard.dictionary(forKey: "parentResponse"),
                                      let child = parentResponse["child"] as? [String],
                                      let childName = child.first {
                                       
                                       
                                       
                                       if let user = viewModelHome.user {
                                           AsyncImage(url: URL(string: user.profilePhoto)) { image in
                                                  image.resizable()
                                                      .frame(width: 50, height: 50)
                                                      .clipShape(Circle())
                                              } placeholder: {
                                                  Image(systemName: "person.circle")
                                                      .resizable()
                                                      .frame(width: 50, height: 50)
                                              }
                                       } else {
                                           Text("Loading...")
                                               .font(.subheadline)
                                               .foregroundColor(.white)
                                               .onAppear {
                                                   viewModelHome.getUserById(id: childName)
                                               }
                                       }}
                               }
                        HStack{
                            Text("Overall performance")
                                .font(.subheadline)
                                .foregroundColor(.white)

                            Spacer()

                            Text("50%")
                                .font(.subheadline)
                                .foregroundColor(.white)

                                
                        }
                        HStack{
                            ProgressBar(progress: 0.5)

                        }
                           }
                    .padding()
                    .background(Color(0xFF016DB1))
                    .cornerRadius(10)
                    .padding(.horizontal, 0)
                    .frame(height: 130)
                    
                    
                    
                    
                    
                    
                    VStack (spacing: 20){
                        Text("Academics").frame(maxWidth: .infinity, alignment: .leading)
                           
                        HStack(alignment: .center, spacing: 0){
                           Image("bbb")
                                .onTapGesture {
                                                modalAttendance = true
             
                                }
                                .sheet(isPresented: $modalAttendance) {
                                    AttendanceView()
                                }
                            
                              Spacer()
                            Image("ddd")
                                .onTapGesture {
                                                feeAttendance = true
             
                                }
                                .sheet(isPresented: $feeAttendance) {
                                    if let parentResponse = UserDefaults.standard.dictionary(forKey: "parentResponse"),
                                       let child = parentResponse["child"] as? [String],
                                       let childName = child.first {
                                      
                                     // Do something with the childName value
                                        PaymentListView(studentId: childName)
                                 }
                                }
                            Spacer()

                            Image("aaa")
                                .onTapGesture {
                                                askTeacher = true
             
                                }
                                .sheet(isPresented: $askTeacher) {
                                   ChatList()
                                }
                            Spacer()

                            Image("ccc")
                             
                        }
                       
                           }
                    .padding()
                    .background(Color(0xFFFFFFFF))
                    .cornerRadius(10)
                    .frame(height: 150)
                    .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 4)
                    

                    Text("News updates").frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    
                   
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModelExam.exams, id: \.id) { exam in
                                Button(action: {
                                    selectedExamId = exam.id
                                    self.isShowingDetails2.toggle()
                                }) {
                                    HStack{
                                        Text("New Exam : \(exam.name)")
                                                .font(.subheadline)
                                                .padding(.leading, 4)
                                            Spacer()

                                            Text("Check")
                                                .font(.subheadline)
                                                .padding(.trailing, 4)
                                                .foregroundColor(Color(0xFF016DB1))

                                       
                                           }
                                    .padding()
                                    .padding(.vertical,5)
                                    .background(Color(0xFFDDF0FC))
                                    .cornerRadius(10)
                                    .frame(width: 360,height: 80)
                                }
                                
                            }
                        }
                       
                    }
                    .sheet(isPresented: $isShowingDetails2) {
                        
                        if let examId = selectedExamId {
                               ExamDetailsView(examId: examId)
                           }
                        
                    }
                           
                   
                    
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
            
        }
       
    }
}

struct ParentHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ParentHomeView()
    }
}
struct ProgressBar: View {
    var progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 3)
                    .opacity(0.9)
                    .foregroundColor(Color.gray)

                Rectangle()
                    .frame(width: min(CGFloat(self.progress)*geometry.size.width, geometry.size.width), height: 3)
                    .foregroundColor(Color.white)
            }
        }
    }
}



