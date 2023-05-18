//
//  singleitemcalendar_view.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 7 on 2/5/2023.
//

import SwiftUI

struct singleitemcalendar_view: View {
    let classname : String
    let starttime : String
    let endtime : String
    let subject : String
    var body: some View {
        HStack{
            Text("#6572")
                .foregroundColor(.lightGray)
            
            
            VStack(alignment: .leading){
                HStack{
                    Text(classname)
                    .bold()
                    Text("-")
                    Text(subject).bold()
                }
                HStack{
                    Text(starttime)
                    Text("-")
                    Text(endtime)
                }
                
               
            }.padding()
            
            Spacer()
        }.padding(.horizontal)
            .background(Color.gray.opacity(0.15))
    }
}

struct singleitemcalendar_view_Previews: PreviewProvider {
    static var previews: some View {
        singleitemcalendar_view(classname: "3 éme 2", starttime:"dd" , endtime: "dd", subject: "4sim")
    }
}
