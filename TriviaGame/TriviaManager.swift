//
//  TriviaManager.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 14/3/25.
//

import SwiftUI

class TriviaManager: ObservableObject {
    
    // List of trivia questions fetched from the API
    private(set) var trivia: [Trivia.Result] = []
    
    // Notify the UI whenever their values change
    @Published private(set) var lenght = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    
    @Published var timeRemaining: Int = 20
    @Published private(set) var angle: Double = 0
    @Published private(set) var fillAmount: CGFloat = 0
    
    private var timer: Timer?
    
    @Published var normalGameMode = true
    
    // Trivia settings
    @Published var difficulty = "easy"
    @Published var category = "9"
    @Published var amount = 10
    
    // Dropdown Options
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
    
    
    func saveHighScore() {
        let currentScore = score
        let savedScore = UserDefaults.standard.integer(forKey: "highScore")
        
        if currentScore > savedScore {
            UserDefaults.standard.set(currentScore, forKey: "highScore")
        }
    }
    
    func getHighScore() -> Int {
        return UserDefaults.standard.integer(forKey: "highScore")
    }
    
    // Saving user settings
    func saveSettings() {
        UserDefaults.standard.set(difficulty.lowercased(), forKey: "difficulty")
        UserDefaults.standard.set(category, forKey: "category")
        UserDefaults.standard.set(amount, forKey: "amount")
    }
    
    
    // Fetching trivia data
    func fetchTrivia(difficulty: String, category: String, amount: Int) async {
        
        guard let url = URL(string: "https://opentdb.com/api.php?amount=\(amount)&category=\(category)&difficulty=\(difficulty)") else { fatalError("Missing URL") }
        
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
                self.setQuestion()
                
                // Stores the selected difficulty
                self.difficulty = difficulty
                self.category = category
                self.amount = amount
                
                // Resetting quiz state
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false
                
                // Storing fetched questions
                self.trivia = decodedData.results
                self.lenght = self.trivia.count
                
                // Checking if Questions exists and setting the first question
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
    
    func starTimer() {
        timer?.invalidate()
        
        fillAmount = 0
        angle = 0
        
        let duration = normalGameMode ? 20 : 60
        timeRemaining = Int(Double(duration))
        
        withAnimation(.linear(duration: Double(duration))) {
            fillAmount = 1
            angle += 360
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                resetTimerVisuals()
                self.reachedEnd = true
            }
        })
    }
    
    func resetTimerVisuals() {
        withAnimation {
            fillAmount = 0
            angle = 0
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
            
            if normalGameMode {
                starTimer()
            }
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        
        if answer.isCorrect {
            score += 1
        }
        
        if normalGameMode {
            timer?.invalidate()
            resetTimerVisuals()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.goToNextQuestion()
        }
    }
}

class NavigatorCoordinator: ObservableObject {
    @Published var path = NavigationPath()
}
