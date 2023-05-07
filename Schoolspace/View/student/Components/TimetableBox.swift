//
//  SubjectBox.swift
//  School space
//
//  Created by Mohamed Abbes on 6/4/2023.
//

import SwiftUI
struct TimeTableBox: View {
    let name: String
    let startDate: String
    let endDate: String

    
    func getTimeString(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }

    var body: some View {
        GeometryReader { geometry in
            HStack {
                if let unwrappedImage = UIImage(systemName: "person.crop.circle.fill") {
                    Image("assets")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                        .cornerRadius(20)
                        .padding(10)
                } else {
                    Rectangle()
                        .fill(Color.gray)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                }
                VStack{
                    Text(name)
                        .font(.headline)
                        .frame(width: 250, alignment: .leading)
                        .alignmentGuide(.leading) { d in d[.leading] }
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    HStack{
                        if let startTime = getTimeString(from: startDate) {
                            Text("Starts at \(startTime)")
                                .font(.headline)
                                .frame(width: 125, alignment: .leading)
                                .alignmentGuide(.leading) { d in d[.leading] }
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        }
                        if let endTime = getTimeString(from: endDate) {
                            Text("Ends at \(endTime)")
                                .font(.headline)
                                .frame(width: 125, alignment: .leading)
                                .alignmentGuide(.leading) { d in d[.leading] }
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        }
                    }
                    
                    
                }
               
            }
            
            .frame(width: geometry.size.width, height: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            
            .padding(.vertical, 10)
            .shadow(radius: 1)
            
        }}
    
  
}

