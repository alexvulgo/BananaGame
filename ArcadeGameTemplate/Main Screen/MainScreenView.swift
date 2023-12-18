//
//  MainScreen.swift
//  ArcadeGameTemplate
//

import SwiftUI

/**
 * # MainScreenView
 *
 *   This view is responsible for presenting the game name, the game intructions and to start the game.
 *  - Customize it as much as you want.
 *  - Experiment with colors and effects on the interface
 *  - Adapt the "Insert a Coin Button" to the visual identity of your game
 **/

struct MainScreenView: View {
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    
    // Change it on the Constants.swift file
    var gameTitle: String = MainScreenProperties.gameTitle
    
    // Change it on the Constants.swift file
    let accentColor: Color = MainScreenProperties.accentColor
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 16.0) {
                    
                    Spacer()
                    /**
                     * # PRO TIP!
                     * The game title can be customized to represent the visual identity of the game
                     */
                    Text("\(self.gameTitle)")
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                        .glowBorder(color: Color("mybrown"), lineWidth: 5)
                        .padding(.bottom, 40)
                    
                    
                    
                    /**
                     * Customize the appearance of the **Insert a Coin** button to match the visual identity of your game
                     */
                    Button {
                        withAnimation { self.startGame() }
                    } label: {
                        Text("Play")
                            .padding()
                            .frame(maxWidth: 300)
                    }
                    
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                    .glowBorder(color: Color("mybrown"), lineWidth: 5)
                    .padding(.bottom, 5)
                    
                    NavigationLink(destination: {
                        CreditView()
                    }, label: {
                        Text("Score")
                            .padding()
                            .frame(maxWidth: 300)
                    })
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                    .glowBorder(color: Color("mybrown"), lineWidth: 5)
                    .padding(.bottom, 40)
                    
                    
                    Spacer()
                }
                .foregroundColor(.blue)
                .padding()
                .statusBar(hidden: true)
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
    MainScreenView(currentGameState: .constant(GameState.mainScreen))
}
