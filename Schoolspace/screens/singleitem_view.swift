import SwiftUI

struct ListViewCell: View {
    let name: String

    let email: String

    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            HStack {
                Text("#6572")
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
                        // Delete account action
                    }) {
                        Text("Accept Account")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)

                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                            

                    }
                    
                    Button(action: {
                        // Delete account action
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
}

struct singleitem_view_Previews: PreviewProvider {
    static var previews: some View {
        ListViewCell(name:"Beyram Ayadi" ,email: "beyram.ayadi@esprit.tn")
    }
}
