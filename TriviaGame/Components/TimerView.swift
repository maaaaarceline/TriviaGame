//
//  TimerView.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 28/3/25.
//

import SwiftUI

struct TimerView: View {
    
    var angle: Double
    var fillAmount: CGFloat
    var timeRemaining: Int
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke(lineWidth: 15)
                .frame(width: 100, height: 100)
                .foregroundStyle(.gray.opacity(0.3))
            Circle()
                .trim(from: 0, to: fillAmount)
                .stroke(style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round))
                .frame(width: 100, height: 100)
                .foregroundStyle(.white)
                .rotationEffect(.degrees(-90))
            
            HStack {
                Text("\(timeRemaining)")
                    .formattedTitle()
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    TimerView(angle: 0, fillAmount: 0, timeRemaining: 20)
}
