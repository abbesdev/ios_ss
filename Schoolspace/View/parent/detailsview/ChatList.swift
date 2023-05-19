//
//  ChatList.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 7/5/2023.
//

import SwiftUI
import LocalAuthentication

struct ChatList: View {
    @State var users: [UserResponseChat] = []
    @State private var isShowingDetailsChat = false
    @State private var selectedReceiverId: String?
    @State private var selectedReceiverName: String?
    @State private var isUnlocked = false

    var body: some View {
        VStack {
            Text("Chat Space")
                .font(.title2)
            List(users) { user in
                Button(action: {
                    selectedReceiverId = user.id
                    selectedReceiverName = user.firstName

                    self.isShowingDetailsChat.toggle()
                }) {
                    HStack {
                        AsyncImage(url: URL(string: user.profilePhoto)) { image in
                               image.resizable()
                                   .frame(width: 50, height: 50)
                                   .clipShape(Circle())
                           } placeholder: {
                               Image(systemName: "person.circle")
                                   .resizable()
                                   .frame(width: 50, height: 50)
                           }
                        Text("\(user.firstName) \(user.lastName)")
                    }}
            }
            .onAppear {
                getUsers()
            }
        }
        .padding()
        .sheet(isPresented: $isShowingDetailsChat) {
            
            if let userId = selectedReceiverId, let senderId = UserDefaults.standard.dictionary(forKey: "parentResponse")?["_id"] as? String {
                ChatView(senderId: senderId, receiverId: userId, subjectName: "Random", teacherName: selectedReceiverName ?? "")
            }
            
        }
    }
    
    func getUsers() {
        let url = URL(string: "https://backspace-gamma.vercel.app/users")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedUsers = try? JSONDecoder().decode([UserResponseChat].self, from: data) {
                    users = decodedUsers.filter { $0.userRole == "teacher" }
                }
            }
        }.resume()
    }
}

struct UserResponseChat: Codable, Identifiable {
    let id: String
    let firstName: String
    let lastName: String
    let userRole: String
    let profilePhoto: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName
        case lastName
        case userRole
        case profilePhoto
    }
}






