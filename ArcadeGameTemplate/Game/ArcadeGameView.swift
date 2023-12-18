//
//  GameView.swift
//  ArcadeGameTemplate
//

import SwiftUI
import SpriteKit

/**
 * # ArcadeGameView
 *   This view is responsible for presenting the game and the game UI.
 *  In here you can add and customize:
 *  - UI elements
 *  - Different effects for transitions in and out of the game scene
 **/

struct ArcadeGameView: View {
    
    /**
     * # The Game Logic
     *     The game logic keeps track of the game variables
     *   you can use it to display information on the SwiftUI view,
     *   for example, and comunicate with the Game Scene.
     **/
    @StateObject var gameLogic: ArcadeGameLogic =  ArcadeGameLogic.shared
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    
    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    /**
     * # The Game Scene
     *   If you need to do any configurations on your game scene, like changing it's size
     *   for example, do it here.
     **/
    var arcadeGameScene: ArcadeGameScene {
        let scene = ArcadeGameScene()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        
        return scene
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            SpriteView(scene: self.arcadeGameScene)
                .frame(width: screenWidth*1.1, height: screenHeight*1.1)
                .statusBar(hidden: true)
            
            VStack {
                
                HStack(){
                    
                   Spacer()
            
                    GameScoreView(score: $gameLogic.currentScore)
                        .padding()
                
                }
                .padding()
                .padding(.top, 40)
                
                Spacer()
                
            }
        }
        .ignoresSafeArea()
        
        
        .onChange(of: gameLogic.isGameOver) { _ , _ in
            if gameLogic.isGameOver {
                
                /** # PRO TIP!
                 * You can experiment by adding other types of animations here before presenting the game over screen.
                 */
                
                withAnimation {
                    self.presentGameOverScreen()
                }
            }
        }
        .onAppear {
            gameLogic.restartGame()
        }
    }
    
    /**
     * ### Function responsible for presenting the main screen
     * At the moment it is not being used, but it could be used in a Pause menu for example.
     */
    private func presentMainScreen() {
        self.currentGameState = .mainScreen
    }
    
    /**
     * ### Function responsible for presenting the game over screen.
     * It changes the current game state to present the GameOverView.
     */
    private func presentGameOverScreen() {
        self.currentGameState = .gameOver
    }
}

#Preview {
    ArcadeGameView(currentGameState: .constant(GameState.playing))
}
