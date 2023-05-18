//
//  admin_view.swift
//  schoolspace-beyram
import SwiftUI


extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}


struct AdminView: View {
    @State var menuOpen: Bool = false
    @State private var selection = 0
    @State private var userCount: Int = 0
    @State private var counts: [Int] = [88, 88, 88, 88]
     // initialize counts to zero
    @StateObject var api = Api()



    var body: some View {
        
            
            
            
            VStack(spacing: 20) {
                
                
                HStack{
                    Image("profile")
                    
                        .resizable()
                        .padding(.leading ,10)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                        
                        Text("Good Morning,")
                            .font(.system(size:20))
                            .foregroundColor(Color(0xFF016DB1))
                        
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Mr. Beyram")
                            .font(.system(size:20))
                            .bold()
                        
                        .frame(maxWidth: .infinity, alignment: .leading)}
                    
                    
                }
                
                
                
                HStack(spacing: 20) {
                    BoxView(title: "Total Users", number: "\(counts[0])")
                    
                }.onAppear(perform: loadData)
                .padding(.horizontal, 10)
                
                HStack(spacing: 20) {
                    BoxView(title: "Students", number: "\(counts[1])")
                    
                }
                .padding(.horizontal, 10)
                HStack(spacing: 20) {
                    BoxView(title: "Parents", number: "\(counts[2])")
                    
                }
                .padding(.horizontal, 10)
                HStack(spacing: 20) {
                    BoxView(title: "Teachers", number: "\(counts[3])")
                    
                }
                .padding(.horizontal, 10)
                
                Spacer()
               
            }
            .padding(.top, 30)
            .foregroundColor(.darkGray)
        
        
            
        }
    func loadData() {
        guard let url = URL(string: "http://\(api.baseurl):8080/userscount") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let countsResponse = try JSONDecoder().decode(UserCountsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.counts[0] = countsResponse.counts[0]
                    self.counts[1] = countsResponse.counts[1]
                    self.counts[2] = countsResponse.counts[2]
                    self.counts[3] = countsResponse.counts[3]

                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    
    
  /*  func fetchUserCount() {
           guard let url = URL(string: "http://localhost:8080/userscount") else {
               print("Invalid URL")
               return
           }
           
           URLSession.shared.dataTask(with: url) { data, response, error in
               if let error = error {
                   print("Error: \(error)")
                   return
               }
               
               guard let httpResponse = response as? HTTPURLResponse,
                     (200...299).contains(httpResponse.statusCode) else {
                   print("Invalid response")
                   return
               }
               
               guard let data = data else {
                   print("No data received")
                   return
               }
               
               do {
                  let userCountResponse = try JSONDecoder().decode(UserCountResponse.self, from: data)
                   DispatchQueue.main.async {
               
                       self.userCount = userCountResponse.userCount
                   }
               } catch {
                   print("Error decoding response: \(error)")
               }
           }.resume()
       }*/
    
    
}

struct BoxView: View {
    var title: String
    var number: String
    
    var body: some View {
        
        VStack {
            Text(title)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(.darkGray)
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(height: 25)
            
            Text(number)
                .font(.system(size: 25))
                .fontWeight(.bold)
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
        }

        .frame(height: 120)
        .background(Color.lightGray.opacity(0.2))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
        .cornerRadius(10)
        .padding(.bottom, 10)
        
        
        
    }
    
}

extension Color {
    static let lightGray = Color(.lightGray)
    static let darkGray = Color(.darkGray)
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        
        AdminView()
      
        
    }
}
