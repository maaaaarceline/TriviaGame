//
//  SquareSelector.swift
//  TriviaGame
//
//  Created by Marcela Hernández on 4/4/25.
//

import SwiftUI

struct SquareSelector: View {
    
    var label: String
    var description: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 350, height: 180)
                .foregroundStyle(.white)
                .cornerRadius(25)
            
            VStack (spacing: 15) {
                Text(label)
                    .formattedTitle()
                    .foregroundStyle(.bluePrimary)
                    .fontWeight(.semibold)
                
                Text(description)
                    .foregroundStyle(.gray)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 300, height: 130)
            .padding()
        }
            
    }
}

#Preview {
    SquareSelector(label: "Arcade", description: "Answer all the questions in 1 minute. Could be any category")
}
