//
//  PrimaryButton.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 12/3/25.
//

import SwiftUI

struct PrimaryButton: View {
    
    var text: String
    var background: Color = Color(.white)
    
    var body: some View {
        Text(text)
            .foregroundStyle(.black)
            .fontWeight(.semibold)
            .padding()
            .padding(.horizontal)
            .background(background)
            .cornerRadius(26)
            .shadow(radius: 10)
    }
}

#Preview {
    PrimaryButton(text: "Next")
}
