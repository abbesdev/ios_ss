//
//  quizitem.swift
//  schoolspace-beyram
//
//  Created by Mac-Mini_2021 on 15/05/2023.
//

import SwiftUI


    struct QuizItem: View {
      //  @State private var selectedAnswer = ""

        var question: String
        var answers: [String]
        @Binding var selectedAnswer: String


        var body: some View {
            VStack {
                HStack{
                    Text(question).bold().font(.system(size: 20)).padding()
                    
                    Spacer()}
                HStack{
                    
                    VStack {
                        ForEach(answers.indices, id: \.self) { index in
                            Button(action: {
                                self.selectedAnswer = answers[index]
                            }) {
                                HStack{
                                    
                                    Text(" \(answers[index])")
                                        .padding(6)
                                        
                                        .foregroundColor(selectedAnswer == answers[index] ? Color.white : Color(0xFF016DB1))
                                        
                                Spacer()}  .border(Color(0xFF016DB1), width : 1) .background(selectedAnswer == answers[index] ? Color(0xFF016DB1) : Color.clear)
                                    .cornerRadius(10)   //  .frame(maxWidth: .infinity)
                            }
                        }
                    }.padding(.leading )
                    Spacer()
                }
                
                
            }.padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }

    }

/*
struct quizitem_Previews: PreviewProvider {
    static var previews: some View {
        QuizItem(question: "What is the capital of Tunisia?", answers: ["Cairo","Tunis","Rabat","Rome"],selectedAnswer: $selectedAnswer)
    }
}
*/
