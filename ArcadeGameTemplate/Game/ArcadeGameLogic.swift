//
//  GameLogic.swift
//  ArcadeGameTemplate
//

import Foundation

class ArcadeGameLogic: ObservableObject {
    
    // Single instance of the class
    static let shared: ArcadeGameLogic = ArcadeGameLogic()
    
    let defaults = UserDefaults.standard
    
    // Function responsible to set up the game before it starts.
    func setUpGame() {
        
        // TODO: Customize!
        
        self.currentScore = 0
        self.sessionDuration = 0
        self.counter = 3
        self.isGameOver = false
        
        
    }
    
    // Keeps track of the current score of the player
    @Published var currentScore: Int = 0
    
    
    // Increases the score by a certain amount of points
    func score(points: Int) {
        
        // TODO: Customize!
        
        self.currentScore = self.currentScore + points
    }
    
    
    
    
    // Keep tracks of the duration of the current session in number of seconds
    @Published var sessionDuration: TimeInterval = 0
    
    func increaseSessionTime(by timeIncrement: TimeInterval) {
        self.sessionDuration = self.sessionDuration + timeIncrement
    }
    
    func restartGame() {
        
        // TODO: Customize!
        
        self.setUpGame()
    }
    
    func saveScore() {
        let highScore = UserDefaults.standard.integer(forKey: "highScore")
        if(currentScore > highScore) {
            defaults.set(currentScore, forKey: "highScore")
        }
    }
    
    // Game Over Conditions
    @Published var isGameOver: Bool = false
    
    func finishTheGame() {
        if self.isGameOver == false {
            print("Game over triggered")
            
            self.isGameOver = true
        }
        self.saveScore()
    }
    
    @Published var  counter : Int = 0
    
    func decrementCounter() {
        counter -= 1
    }
    
}
