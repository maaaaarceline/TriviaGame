//
//  AnswerRow.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 13/3/25.
//

import SwiftUI

struct AnswerRow: View {
    
    @EnvironmentObject var triviaGame: TriviaManager
    
    var answer: Answer
    @State private var isSelected = false
    
    var green = Color(hue: 0.437, saturation: 0.711, brightness: 0.771)
    var red = Color(red: 0.71, green: 0.094, blue: 0.1)
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "circle.fill")
                .font(.caption)
            
            Text(answer.text)
                .bold()
            
            if isSelected {
                Spacer()
                
                Image(systemName: answer.isCorrect ? "checkmark.circle.fill" : "x.circle.fill")
                    .foregroundStyle(answer.isCorrect ? green : red)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(triviaGame.answerSelected ? (isSelected ? Color("BluePrimaryColor") : .gray)  : Color("BluePrimaryColor"))
        .background(.white)
        .cornerRadius(10)
        .shadow(color: isSelected ? (answer.isCorrect ? green : red) : .gray, radius: 5, x: 0.5, y: 0.5)
        .onTapGesture {
            if !triviaGame.answerSelected {
                isSelected = true
                triviaGame.selectAnswer(answer: answer)
            }
            isSelected = true
        }
        .disabled(triviaGame.answerSelected)
    }
}

#Preview {
    AnswerRow(answer: Answer(text: "single", isCorrect: false)).environmentObject(TriviaManager())
}
