//
//  ContentView.swift
//  ArcadeGameTemplate
//

import SwiftUI

/**
 * # ContentView
 *
 *   This view is responsible for managing the states of the game, presenting the proper view.
 **/

struct ContentView: View {
    
    // The navigation of the app is based on the state of the game.
    // Each state presents a different view on the SwiftUI app structure
    @State var currentGameState: GameState = .mainScreen
    
    // The game logic is a singleton object shared among the different views of the application
    @StateObject var gameLogic: ArcadeGameLogic = ArcadeGameLogic()
    
    var body: some View {
        
        switch currentGameState {
        case .mainScreen:
            MainScreenView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
            
        case .playing:
            ArcadeGameView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
            
            
            
        case .gameOver:
            GameOverView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        }
    }
}

#Preview {
    ContentView()
}
