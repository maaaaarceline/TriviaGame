//
//  ContentView.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 12/3/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var triviaManager = TriviaManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                
                Image(.triviaIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
                VStack(spacing: 20) {
                    Text("Trivia Game")
                        .formattedTitle()
                        .foregroundStyle(.white)
                    
                    Text("Are you ready to test out your trivia skills?")
                        .foregroundStyle(.white)
                        .fontWeight(.medium)
                }
                
                NavigationLink {
                    ModeSelectorView().environmentObject(triviaManager)
                } label : {
                    PrimaryButton(text: "Let's Go!")
                }
                
                if triviaManager.getHighScore() > 0 {
                    Text("Best Score")
                        .formattedTitle()
                        .foregroundStyle(.white)
                ZStack {

                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.darkYellowBulb)
                        .offset(x: -5)
                    
                        Text("\(triviaManager.getHighScore())")
                        .formattedTitle()
                        .foregroundStyle(.bluePrimary)
                        .frame(width: 60, height: 60)
                        .background(
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundStyle(.yellowBulb)
                                .frame(width: 80, height: 80)
                        )
                    
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("backgroundFoto")
                .resizable()
                .aspectRatio(contentMode: .fill))
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
