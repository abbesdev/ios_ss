//
//  quizmarkitem.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 09/05/2023.
//

import SwiftUI

struct quizmarkitem: View {
    let name: String
    let mark: Int

    var body: some View {
        let text = String(mark)+"/20"

        HStack{
            Text(name).bold()
                .font(.system(size: 20))
            Spacer()
          
                Text(text)
                    .font(.system(size: 20))
                  
                    .bold()
            
        } .cornerRadius(8)
            .padding(25)
          //  .border(Color.lightGray, width : 0.5)
            .frame(maxWidth: .infinity)
            .border(Color.black, width : 1)
    }
}

struct quizmarkitem_Previews: PreviewProvider {
    static var previews: some View {
        quizmarkitem(name: "Android", mark: 15)
    }
}
