//
//  EventBox.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 3/5/2023.
//

import SwiftUI
import URLImage

struct EventBox: View {
    let name: String
    let image: String
    let description: String

    var body: some View {
        ZStack {
            URLImage(URL(string: image)!) { proxy in
                proxy
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    .frame(width: .infinity,height: 170)
            
            
                       }
            VStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                        .padding(.leading, 4)
                        .foregroundColor(.white)
                    
                    Text(description)
                        .font(.subheadline)
                        .padding(.leading, 4)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 20)
                .padding(.top, 20)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .background(Color.black)
                .opacity(0.7)
            }
            .frame(height: 170)
        }
        .cornerRadius(10)
        .padding(.vertical,10)
    }
}


