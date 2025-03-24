//
//  Answer.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 13/3/25.
//

import Foundation

// This model will tell swift which variables each Answer must contain.

struct Answer: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
