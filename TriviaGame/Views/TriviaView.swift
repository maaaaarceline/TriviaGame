//
//  TriviaView.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 13/3/25.
//

import SwiftUI

struct TriviaView: View {
    
    @EnvironmentObject var triviaGame: TriviaManager
    
    var body: some View {
        
        if triviaGame.reachedEnd {
            
            NavigationView {
                ZStack {
                    
                    Image("backgroundFoto")
                        .resizable()
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        
                        Image(.triviaIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                        
                        Text("Trivia Game")
                            .formattedTitle()
                        
                        Text("Congratulations, you completed the game!")
                            .fontWeight(.semibold)
                        
                        Text("You scored  \(triviaGame.score) of \(triviaGame.lenght)")
                            .fontWeight(.semibold)
                        
                        Button {
                            Task {
                                await triviaGame.fetchTrivia(difficulty: triviaGame.difficulty, category: triviaGame.category, amount: triviaGame.amount)
                                triviaGame.saveHighScore()
                            }
                        } label: {
                            PrimaryButton(text: "Play Again")
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: ContentView().environmentObject(triviaGame)
                            .onAppear() {
                                Task {
                                    triviaGame.saveHighScore()
                                }
                            }
                        ) {
                            Image(systemName: "house.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        //                    NavigationLink {
                        //                        ContentView().environmentObject(triviaGame)
                        //
                        //                    } label: {
                        //                        Image(systemName: "house.circle.fill")
                        //                            .resizable()
                        //                            .frame(width: 60, height: 60)
                        //                            .aspectRatio(contentMode: .fit)
                        //                    }
                    }
                    .foregroundStyle(Color(.white))
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .navigationBarHidden(true)
            }
            .navigationBarHidden(true)
            
            
        } else {
            QuestionView().environmentObject(triviaGame).navigationBarHidden(true)
        }
        
    }
    
}

#Preview {
    TriviaView().environmentObject(TriviaManager())
}
