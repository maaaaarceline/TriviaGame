//
//  QuestionView.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 12/3/25.
//

import SwiftUI

struct QuestionView: View {
    
    @EnvironmentObject var triviaGame: TriviaManager
    
    var body: some View {
        ZStack {
            
            Image("backgroundPhoto")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 60) {
                
                
                HStack {
                        Text("Trivia Game")
                            .formattedTitle()
                            .foregroundStyle(.white)

                    Spacer()
                    
                    TimerView(angle: triviaGame.angle, fillAmount: triviaGame.fillAmount, timeRemaining: triviaGame.timeRemaining)
                }
                
                VStack {
                    Text("\(triviaGame.index + 1) out of \(triviaGame.lenght)")
                        .foregroundStyle(Color(.white))
                        .fontWeight(.heavy)
                    
                    ProgressBar(progress: triviaGame.progress)
                }
     
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(triviaGame.question)
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(.white)
                    
                    ForEach(triviaGame.answerChoices, id: \.id) { answer in
                        AnswerRow(answer: answer).environmentObject(triviaGame)
                        
                    }
                }
                
//                Button {
//                    triviaGame.goToNextQuestion()
//                    
//                } label: {
//                    PrimaryButton(text: "Next", background: triviaGame.answerSelected ? Color(.white) : .gray)
//                }
//                .disabled(!triviaGame.answerSelected)
                
                Spacer()
            }
            .onAppear {
                triviaGame.setQuestion()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
        
        
    }
    
}

#Preview {
    QuestionView().environmentObject(TriviaManager())
}
