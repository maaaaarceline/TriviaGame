//
//  SelectorView.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 20/3/25.
//

import SwiftUI

struct SelectorView: View {
    
    @StateObject var triviaManager = TriviaManager()
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                Image(.backgroundPhoto)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text("Quiz Settings").formattedTitle()
                        .foregroundStyle(.white)
                        .padding()
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        
                        // Difficulty
                        HStack {
                            Text("Difficulty:")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                            Spacer()
                            Picker("Difficulty", selection: $triviaManager.difficulty) {
                                ForEach(triviaManager.difficulties, id: \.self) { difficulty in
                                    Text(difficulty).tag(difficulty)
                                }
                            }
                        }
                        .padding(35)
                        
                        // Category
                        HStack {
                            Text("Category:")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                            Spacer()
                            Picker("Category", selection: $triviaManager.category) {
                                ForEach(triviaManager.categories.keys.sorted(), id: \.self) { category in
                                    Text(category).tag(triviaManager.categories[category]!)
                                }
                            }
                            
                        }
                        .padding(35)
                        
                        HStack {
                            Text("Question Number:")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                            Spacer()
                            
                            
                            
                            
                            Picker("Question Number", selection: $triviaManager.amount) {
                                ForEach(triviaManager.questionAmount, id: \.self) { amount in
                                    Text("\(amount)").tag(amount)
                                }
                            }
                        }
                        .padding(35)
                        
                        
                    }
                    .padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: TriviaView().environmentObject(triviaManager)
                        .onAppear() {
                            Task {
                                await triviaManager.fetchTrivia(difficulty: triviaManager.difficulty, category: triviaManager.category, amount: triviaManager.amount)
                                triviaManager.saveSettings()
                            }
                        }
                    ) {
                        PrimaryButton(text: "Start Quiz")
                    }
                    
                }
            }
        }
        .navigationBarHidden(true)
        
    }
}



#Preview {
    SelectorView()
}
