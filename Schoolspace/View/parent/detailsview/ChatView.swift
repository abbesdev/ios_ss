//
//  ChatView.swift
//  Schoolspace
//
//  Created by Mohamed Abbes on 7/5/2023.
//

import SwiftUI

struct ChatView: View {
    @State var messages: [ChatMessage] = []
    @State var newMessage: String = ""
    let senderId: String // ID of the current user (e.g. parent)
    let receiverId: String // ID of the teacher the user is chatting with
    let subjectName: String // Name of the subject the teacher is teaching
    let teacherName: String // Name of the subject the teacher is teaching
    
    var body: some View {
        VStack {
            Text("Teacher : \(teacherName)")
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(messages) { messager in
                        ChatMessageRow(message: messager.message, isSender: messager.sender == senderId)
                    }
                }
            }
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Button(action: {
                    let message = ChatMessage(sender: senderId, receiver: receiverId, message: newMessage, timestamp: "")
                    sendChatMessage(message) { result in
                        switch result {
                        case .success(let response):
                            self.messages.append(response)
                            self.newMessage = ""
                        case .failure(let error):
                            print("Error sending chat message: \(error)")
                        }
                    }
                }) {
                    Text("Send")
                }
                .disabled(newMessage.isEmpty)
                .padding(.horizontal)
            }
        }
        .padding()
        .navigationBarTitle(Text(subjectName), displayMode: .inline)
        .onAppear {
                    fetchChatHistory()
                }
    }
    func fetchChatHistory() {
        guard let url = URL(string: "https://backspace-gamma.vercel.app/chat/\(senderId)/\(receiverId)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching chat history: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                print("Server error: \(httpResponse.statusCode)")
                return
            }
            
            guard let jsonData = data else {
                print("Invalid data")
                return
            }
            print(httpResponse.statusCode)

            let jsonDecoder = JSONDecoder()
            do {

                let chatMessages = try jsonDecoder.decode([ChatMessage].self, from: jsonData)
                DispatchQueue.main.async {
                    self.messages = chatMessages
                }
            } catch {
                print("Error decoding chat history: \(error)")
            }
        }
        task.resume() // Add this line to start the task
    }
    func sendChatMessage(_ chatMessage: ChatMessage, completion: @escaping (Result<ChatMessage, Error>) -> Void) {
        guard let url = URL(string: "https://backspace-gamma.vercel.app/chat") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(chatMessage)
            request.httpBody = jsonData
      
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                    return
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    completion(.failure(NSError(domain: "Server error", code: httpResponse.statusCode, userInfo: nil)))
                    return
                }
                
                guard let jsonData = data else {
                    completion(.failure(NSError(domain: "Invalid data", code: 0, userInfo: nil)))
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let chatMessage = try jsonDecoder.decode(ChatMessage.self, from: jsonData)
                    completion(.success(chatMessage))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }


}

struct ChatMessageRow: View {
    let message: String
    let isSender: Bool
    
    var body: some View {
        HStack {
            if isSender {
                Spacer()
            }
            Text(message)
                .padding()
                .foregroundColor(.white)
                .background(isSender ? Color.blue : Color.green)
                .cornerRadius(10)
            if !isSender {
                Spacer()
            }
        }
    }
}
