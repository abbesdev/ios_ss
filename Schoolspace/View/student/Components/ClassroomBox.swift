//
//  SubjectBox.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import SwiftUI
struct ClassroomBox: View {
    let name: String
    

    
   
    var body: some View {
        
        HStack {
           
                Image("clr")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                    .cornerRadius(20)
                    .padding(10)
           
                Text(name)
                    .font(.headline)
                                    .frame(width: 250, alignment: .leading)
                                    .alignmentGuide(.leading) { d in d[.leading] }
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
              
              

            
            Spacer()
        }
        .padding(10)
        .frame(width: .infinity, height: 100)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 1)
       
    }
    
  
}

