//
//  SubjectBox.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import SwiftUI
struct SubjectBox: View {
    let name: String
    let imageUrl: String
    
    @State private var image: UIImage?
    
    var body: some View {
        
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 150)
                    .foregroundColor(.blue)
                    .cornerRadius(20)
                    .padding(10)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 150)
                    .foregroundColor(.blue)
            }
            Text(name)
                .font(.headline)
                                .frame(width: 250, alignment: .leading)
                                .alignmentGuide(.leading) { d in d[.leading] }
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
            Spacer()
        }
        .padding(10)
        .frame(width: 270, height: 220)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 1)
        .onAppear(perform: loadImage)
    }
    
    private func loadImage() {
        guard let url = URL(string: imageUrl) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
