//
//  ModeSelectorView.swift
//  TriviaGame
//
//  Created by Marcela Hernández on 4/4/25.
//

import SwiftUI

struct ModeSelectorView: View {
    
    @StateObject var triviaManager = TriviaManager()
    
    var body: some View {
        NavigationStack() {
            
            ZStack {
                
                Image(.backgroundPhoto)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 90) {
                    
                    Text("Game Mode")
                        .formattedTitle()
                        .foregroundStyle(.white)
                    
                    
                    NavigationLink {
                        SelectorView().environmentObject(triviaManager)
                    } label: {
                        SquareSelector(label: "Normal", description: "Test your knowledge in your selected category") }
                    
                    
                    NavigationLink {
                        ArcadeModeView().environmentObject(triviaManager)
                    } label: {
                        SquareSelector(label: "Arcade", description: "Answer as fast as you can")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ModeSelectorView()
}
