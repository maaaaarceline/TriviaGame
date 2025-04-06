//
//  ArcadeModeView.swift
//  TriviaGame
//
//  Created by Marcela Hernández on 4/4/25.
//

import SwiftUI

struct ArcadeModeView: View {
    
    @StateObject var triviaManager = TriviaManager()
    @State var timeOut = 60
    @State var startGame = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image(.backgroundFoto)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .blur(radius: startGame ? 0 : 10)
                
                if !startGame {
                    
                    VStack {
                        
                        Text("START")
                            .font(.system(size: 60))
                            .formattedTitle()
                            .frame(width: 300, height: 100, alignment: .center)
                            .foregroundStyle(.white)
                        
                        Text("(Touch the screen to start the game)")
                            .foregroundStyle(.gray.opacity(0.5))

                    }
                    
                } else if triviaManager.timeRemaining > 0 {
                    
                    VStack(spacing: 50) {
                        
                        TimerView(angle: triviaManager.angle, fillAmount: triviaManager.fillAmount, timeRemaining: triviaManager.timeRemaining)
                                            
                        VStack(alignment: .leading, spacing: 20) {
                            Text(triviaManager.question)
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(.white)
                            
                            ForEach(
                                triviaManager.answerChoices,
                                id: \.id
                            ) { answer in
                                AnswerRow(answer: answer).environmentObject(triviaManager)
                                
                            }
                        }
                    }
                    .frame(width: 360, height: 600)
                    .padding()
                    
                } else if triviaManager.timeRemaining == 0 {
                    
                    ZStack {
                        
                        Image(.backgroundFoto)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 40) {
                            
                            Image(.triviaIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 300)
                            
                            Text("TIME'S UP")
                                .formattedTitle()
                                .foregroundStyle(.white)
                            
                            Text("You answered \(triviaManager.score) questions!")
                                .formattedTitle()
                                .foregroundStyle(.white)
                            
                            Button {
                                Task {
                                    await triviaManager.fetchTrivia(difficulty: "medium", category: "9", amount: 50)
                                    triviaManager.saveHighScore()
                                }
                            } label: {
                                PrimaryButton(text: "Play Again")
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: ContentView().environmentObject(triviaManager)
                                .onAppear() {
                                    Task {
                                        triviaManager.saveHighScore()
                                    }
                                }
                            ) {
                                Image(systemName: "house.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .aspectRatio(contentMode: .fit)
                            }
                            
                        }
                    }
                }
            }
            .onTapGesture {
                guard !startGame else { return }
                startGame = true
                triviaManager.normalGameMode = false
                triviaManager.setQuestion()
                
                Task {
                    await triviaManager.fetchTrivia(difficulty: "medium", category: "9", amount: 50)
                }
                triviaManager.starTimer()
                print("Question: \(triviaManager.question)")
            }
        }
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    ArcadeModeView()
}
