//
//  ProgressBar.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 13/3/25.
//

import SwiftUI

struct ProgressBar: View {
    
    var progress: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(maxWidth: 350, maxHeight: 4)
                .foregroundStyle(.gray)
                .cornerRadius(10)
            
            Rectangle()
                .frame(width: max(0, progress.isFinite ? progress : 50), height: 4)
                .foregroundStyle(Color("AccentColor"))
                .cornerRadius(10)
        }
    }
}

#Preview {
    ProgressBar(progress: 50)
}
