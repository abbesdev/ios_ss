import SwiftUI

struct ListViewCell2: View {
    let name: String

    let email: String

    let number: String
    let _id: String
    
    //let onDelete: (User) -> Void

   
    @State private var isExpanded = false
    
    var body: some View {
        
        VStack {
            HStack {
                Text(number)
                    .foregroundColor(.lightGray)
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 40))
                
                Text(name)
                    .font(.headline)
                    .padding(.leading, 8)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            }
            .padding()
            .background(Color.gray.opacity(0.15))
            .onTapGesture {
                isExpanded.toggle()
            }
            
            if isExpanded {
                VStack {
                    HStack(alignment: .top){
                        Text("Email Adress :")
                        Text(email)
                    }
                    
                    
                    Button(action: {
                        deleteUser(userId: _id)
                    }) {
                        Text("Delete Account")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)

                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .border(Color.lightGray, width : 0.5)

                    }
                }
                .padding(.horizontal)
            }
        }
        .animation(.default)
        
        
    }
    
    func deleteUser(userId: String) {
        guard let url = URL(string: "\(Api().baseurl)/users/\(userId)") else {
            print("Invalid URL")
            return
        }
        print(userId)

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error deleting user: \(error.localizedDescription)")
                return
            }

            if let response = response as? HTTPURLResponse,
               response.statusCode == 200 {
                print("User deleted successfully")
                
                    
                // Refresh your user data or UI
                
            }
        }.resume()

    }
    
}

struct singleitem_view_Previews2: PreviewProvider {
    static var previews: some View {
        ListViewCell2(name:"Beyram Ayadi" ,email: "beyram.ayadi@esprit.tn", number: "112345" , _id: "888")
    }
}
