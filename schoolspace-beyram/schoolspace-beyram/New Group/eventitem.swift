//
//  eventitem.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 09/05/2023.
//

import SwiftUI

struct eventitem: View {
    var name :String
    var date : String
    var time : String
    var body: some View {
        ZStack(alignment: .bottom){
          
            //    Image(profile)
            
            Image("event")
            
                .resizable()
                .padding(.leading ,10)
                .padding(.trailing ,10)

                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.clear,.black]), startPoint: .top, endPoint: .bottom)).frame(height: 100).padding(.leading ,10)
                .padding(.trailing ,10)
             //   .frame(width: .infinity, height: .infinity)
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    /*    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.clear,.black]), startPoint: .top, endPoint: .bottom)).frame(height: 100)*/
                    
                    Text(name).foregroundColor(Color.white).bold()
                    Text(date + " - " + time).foregroundColor(Color.white)

                    
                    
                    
                } .padding(.leading ,30)
                    .padding(.bottom,20)
                    .padding(.trailing ,10)
                Spacer()}
        }}
}

struct eventitem_Previews: PreviewProvider {
    static var previews: some View {
        eventitem(name: "SwiftUI Bootcamp v2.0", date: "26 September 2023", time: "14:00")
    }
}
