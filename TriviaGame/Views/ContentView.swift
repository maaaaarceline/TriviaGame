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
                    SelectorView().environmentObject(triviaManager)
                } label : {
                    PrimaryButton(text: "Let's Go!")
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
