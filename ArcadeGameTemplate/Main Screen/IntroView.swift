//
//  IntroView.swift
//  ArcadeGameTemplate
//
//  Created by Alessandro Esposito Vulgo Gigante on 13/12/23.
//

import SwiftUI

struct IntroView: View {
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    
    // Change it on the Constants.swift file
    var gameTitle: String = MainScreenProperties.gameTitle
    
    // Change it on the Constants.swift file
    let accentColor: Color = MainScreenProperties.accentColor
    
    @State var intro: String = "The nature decided that the destiny of a banana was to be eaten."
    
    @State private var check : Bool = false
    @State private var starting : Bool = false
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            
            Text(intro)
                .font(.title)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .onTapGesture {
                    withAnimation {
                        if(check == false) {
                            intro = "But, one day, a new banana was born."
                            check = true
                        } else if (check == true) {
                            intro = "A Banana with consciousness."
                            starting = true
                        } else if (starting == true) {
                            
                            self.startGame()
                            
                            
                            
                        }
                    }
    
                }
        }
        
    }
    
    /**
     * Function responsible to start the game.
     * It changes the current game state to present the view which houses the game scene.
     */
    private func startGame() {
        print("- Starting the game...")
        self.currentGameState = .playing
    }
}

#Preview {
    IntroView(currentGameState: .constant(GameState.mainScreen))
}

