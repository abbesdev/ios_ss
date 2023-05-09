//
//  studenthomeview.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 08/05/2023.
//

import SwiftUI

struct studenthomeview: View {
    var progress: Double = 0.7
    @State private var isShowingSheet = false
    @State private var isShowingSheet1 = false
    @State private var events: [Event] = []


    var body: some View {
     //   Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        VStack( spacing: 2){
            HStack {
                Spacer()
                Text("Overview")
                    .font(.title)
                    
                Spacer()
                Image(systemName: "bell")
                    .font(.title)
            }
            .padding()
            Divider()
               
            VStack (spacing:0){
                HStack {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Mohamed Abbes")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("4 SIM 1")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                    }
                    Spacer()
                    Image("profile")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                }.padding()
                HStack{
                    Text("Overall performance")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("70%")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    
                }.padding()
                HStack{
                    ProgressView(value: progress)
                        .frame(width: 320, height: 4)
                        .accentColor(.white)
                    
                }.padding()
                
            }
            .background(Color(0xFF016DB1))                            .cornerRadius(10)
     
Spacer()
           
            VStack (spacing: 0){
                Text("Academics").frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                   
                HStack(alignment: .center, spacing: 0){
                   Image("aaa")
                    //    .frame(width: 50, height: 50)
                        .onTapGesture {
                                 //       modalAttendance = true
     
                        }
                       
                    
                      Spacer()
                   
                    Image("zzz")
                      ///   .frame(width: 50, height: 50)
                        .onTapGesture {
                            isShowingSheet = true
                        }
                    .sheet(isPresented: $isShowingSheet){
                        quizlistview()
                    }
                    /*
                    Button(action: {
                        isShowingSheet = true
                    }, label: {
                        Text("See Details")
                            .font(.system(size:20))
                            .underline()
                            .foregroundColor(.blue)
                            .bold()
                            .padding(.horizontal ,15)
                    }).sheet(isPresented: $isShowingSheet) {*/
                       
                    Spacer()

                    Image("eee")
                      ///   .frame(width: 50, height: 50)
                        .onTapGesture {
                            isShowingSheet1 = true
                        }
                    .sheet(isPresented: $isShowingSheet1){
                        performanceview()
                    }
                
                     
                }
               
                   }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .frame(height: 150)
            .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 4)
            
            
            
            Spacer()
            
            ScrollView (.horizontal, showsIndicators: false){
                HStack{
                    ForEach(events, id: \.id) { event in
                        eventitem(name: event.name, date: formatDate(date: event.date), time: event.time)
                        //formatDate(date: event.date)
                    }}
            }
            .onAppear {
                getAllEvents() { fetchedEvents, error in
                    if let fetchedEvents = fetchedEvents {
                        events = fetchedEvents
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            ScrollView{
                
            }
            
            
        }
        .padding()
        
        
       
        
        
    }
    
    
    
    func getAllEvents(completion: @escaping ([Event]?, Error?) -> Void) {
        guard let url = URL(string: "http://172.17.7.17:8080/event") else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(nil, error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                completion(nil, error)
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    print("here")
                   

                    let events = try JSONDecoder().decode([Event].self, from: data)
                    completion(events, nil)
                    /*
                     let quizzes = try JSONDecoder().decode([Quiz].self, from: data)
                     completion(quizzes, nil)
                     */
                } catch let error {
                    print("ta7che")

                    completion(nil, error)
                }
            } else {
                let error = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    
    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date2 = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date2)
        } else{
            return "err"
        }
    }
    
    
    
}

struct studenthomeview_Previews: PreviewProvider {
    static var previews: some View {
        studenthomeview()
    }
}
