//
//  quizsingleitem.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 08/05/2023.
//

import SwiftUI

struct quizsingleitem: View {
    let name: String

    let submitted: Bool
    var body: some View {
       
        HStack{
            Text(name).bold()
                .font(.system(size: 20))
            Spacer()
            if(submitted){
                Text("Submitted")
                    .font(.system(size: 20))
                    .foregroundColor(Color.green)
                    .bold()
            }else{
                Text("To do")
                    .bold()
                    .font(.system(size: 20))
            }
        } .cornerRadius(8)
            .padding(25)
          //  .border(Color.lightGray, width : 0.5)
            .frame(maxWidth: .infinity)
            .border(Color.black, width : 1)
    }
}

struct quizsingleitem_Previews: PreviewProvider {
    static var previews: some View {
        quizsingleitem(name: "Android", submitted: true)
    }
}
