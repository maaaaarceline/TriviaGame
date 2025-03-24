//
//  TriviaManager.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 14/3/25.
//

import SwiftUI

class TriviaManager: ObservableObject {
    
    private(set) var trivia: [Trivia.Result] = []
    @Published private(set) var lenght = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    
    let difficulties = ["easy", "medium", "hard"]
    let categories = [
        "General Knowledge": "9",
        "Books": "10",
        "Movies": "11",
        "Music": "12",
        "Musical & Theatres": "13",
        "Television": "14",
        "Video Games": "15",
        "Board Games": "16",
        "Science & Nature": "17",
        "Computer": "18",
        "Mathematics": "19",
        "Mythology": "20",
        "Sports": "21",
        "Geography": "22",
        "History" : "23",
        "Politics": "24",
        "Art": "25",
        "Celebrities": "26",
        "Animals": "27",
        "Vehicles": "28",
        "Comics": "29",
        "Gadgets": "30",
        "Anime & Manga": "31",
        "Cartoon & Animations": "32"
    ]
    let questionAmount = [5, 10, 15, 20, 25, 50]
    
//    init() {
//        Task.init {
//            await fetchTrivia(difficulty: "easy", category: "9", amount: 10)
//        }
//    }
    
    var difficulty: String = "easy"
    var category: String = "9"
    var amount: Int = 10
    
    func fetchTrivia(difficulty: String, category: String, amount: Int) async {
        
//        let difficulty = UserDefaults.standard.string(forKey: "difficulty") ?? "easy"
//        let category = UserDefaults.standard.string(forKey: "category") ?? "9"
//        let amount = UserDefaults.standard.integer(forKey: "amount")
        
        self.difficulty = difficulty
        self.category = category
        self.amount = amount
        
        guard let url = URL(string: "https://opentdb.com/api.php?amount=\(amount)&category=\(category)&difficulty=\(difficulty)") else { fatalError("Missing URL") }
        
        print(url)
        
        let urlRequest = URLRequest(url: url)
        
                
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            // Ensures we got successful response
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Status code: \(response)")
                fatalError("Error while fetching data")
                
            }
            
            
            
            // Decode JSON
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Trivia.self, from: data)
            
            if decodedData.results.isEmpty {
                print("No questions returned!")
            }
            
            // Update UI on Main Thread
            DispatchQueue.main.async {
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false
                
                self.trivia = decodedData.results
                self.lenght = self.trivia.count
                
                print("fetched \(self.lenght) questions")
                print(self.trivia)
                
                if self.lenght > 0 {
                    self.setQuestion()
                } else {
                    print("No questions available!!!")
                }
            }
            
        } catch {
            print("Error fetching trivia: \(error)")
        }
    }
    
    func restartTrivia() async {
        await fetchTrivia(difficulty: self.difficulty, category: self.category, amount: self.amount)
        }
    
    func goToNextQuestion() {
        if index + 1 < lenght {
            index += 1
            setQuestion()
        } else {
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat((Double(index) + 1) / Double(lenght) * 350)
        
        if index < lenght {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.formattedQuestion
            answerChoices = currentTriviaQuestion.answers
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
}
