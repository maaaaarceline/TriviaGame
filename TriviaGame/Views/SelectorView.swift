//
//  SelectorView.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 20/3/25.
//

import SwiftUI

struct SelectorView: View {
    
    @State private var difficulty = "easy"
    @State private var category = "9"
    @State private var amount = 10
    
    @State private var navigateToTrivia = false
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
                            Picker("Difficulty", selection: $difficulty) {
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
                            Picker("Category", selection: $category) {
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
                            
                            
                            
                            
                            Picker("Question Number", selection: $amount) {
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
                                await triviaManager.fetchTrivia(difficulty: difficulty, category: category, amount: amount)
                                saveSettings()
                            }
                        }
                    ) {
                        PrimaryButton(text: "Start Quiz")
                    }
                        
                    
//                    Button {
//                        Task {
//                            await triviaManager.fetchTrivia(difficulty: difficulty.lowercased(), category: category, amount: amount)
//                            navigateToTrivia = true
//                        }
//                    } label: {
//                        PrimaryButton(text: "Start Quiz!")
//                    }
                    
                }
            }
        }
        .navigationBarHidden(true)
        
    }
    
    func saveSettings() {
        UserDefaults.standard.set(difficulty.lowercased(), forKey: "difficulty")
        UserDefaults.standard.set(category, forKey: "category")
        UserDefaults.standard.set(amount, forKey: "amount")
    }
}



#Preview {
    SelectorView()
}
