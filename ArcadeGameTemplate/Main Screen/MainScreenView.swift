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
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    Image ("bananariot")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 336, height: 336)
                        .padding(.bottom, 50)

                    Button {
                        withAnimation { self.startGame() }
                    } label: {
                        Text("PLAY")
                            .padding()
                            .frame(maxWidth: 150)
                            .background(accentColor)
                            .cornerRadius(10)
                    }

                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("mybrown"))
                    .glowBorder(color: Color("mybrown"), lineWidth: 5)
                    .padding(.bottom, 20)


                    NavigationLink(destination: {
                        CreditView()
                    }, label: {
                        Text("SCORE")
                            .padding()
                            .frame(maxWidth: 150)
                            .background(accentColor)
                            .cornerRadius(10)
                    })

                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("mybrown"))
                    .glowBorder(color: Color("mybrown"), lineWidth: 5)
                    .padding(.bottom, 40)

                    Spacer()
                }
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
