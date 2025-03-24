//
//  Trivia.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 13/3/25.
//

import Foundation

struct Trivia: Decodable {
    var results: [Result]
    
    struct Result: Decodable, Identifiable {
        var id: UUID {
            UUID()
        } // Generates a new UUID every time it's accessed
        
        var category: String
        var type: String
        var question: String
        var correctAnswer: String
        var incorrectAnswers: [String]
        
        // Converts the question property string into an AttributedString
        var formattedQuestion: AttributedString {
            do {
                return try AttributedString(markdown: question)
                
            } catch {
                print("Error setting formattedQuestion: \(error)")
                return ""
            }
        }
        
        // Randomizes answer order
        var answers: [Answer] {
            do {
                let correct = [Answer(text: try AttributedString(markdown: correctAnswer), isCorrect: true)]
                let incorrects = try incorrectAnswers.map { answer in
                     Answer(text: try AttributedString(markdown: answer), isCorrect: false)
                }
                let allAnswers = correct + incorrects
                return allAnswers.shuffled()
                
            } catch {
                print("Error setting answers: \(error)")
                return []
            }
        }
    }
}
