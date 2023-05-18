//
//  home_view.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 7 on 3/5/2023.
//

import SwiftUI

struct home_view: View {
    var name: String
        var className: String
        var id: String
        var progress: Double
   
    var body: some View {
        VStack(spacing: 0) {
                   // Header view
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
                   // Rest of the view
       
                VStack(alignment: .leading, spacing: 20){
                    HStack(spacing:0) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(name)
                                .font(.headline)
                                .foregroundColor(.white)
                            HStack{
                                Text(className)
                                
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                Text("|")
                                    .font(.system(size: 14))
                                Text("ID: \(id)")
                                    .font(.system(size: 14))
                                .foregroundColor(.white)}
                            
                            /* Text("Overall performance")
                             ProgressView(value: progress)
                             .frame(width: 100, height: 50)
                             .padding()
                             .accentColor(.white)*/
                        }
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .offset(x: 0)
                        
                        
                        
                    }
                    
                    
                    .foregroundColor(.white)
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Text("Overall performance").foregroundColor(.white)
                            //Text(progress)
                        }
                        ProgressView(value: progress)
                            .frame(width: 360, height: 50)
                            
                        .accentColor(.white)}
                }.frame(maxWidth: .infinity).background(Color.blue)
                .padding()
                //.cornerRadius(radius:20)
                       
                   
                   
                   
                   }
                   .background(Color.white)
    }
}

struct home_view_Previews: PreviewProvider {
    static var previews: some View {
        home_view(name: "Beyram Ayadi", className: "4 SIM 1", id: "191JMT1834", progress: 1)
    }
}
