//
//  GameOverView.swift
//  ArcadeGameTemplate
//

import SwiftUI

struct GameOverView: View {
    
   
    @Binding var currentGameState: GameState
    
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack (alignment: .center) {
                
                Text ("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                    .glowBorder(color: Color("mybrown"), lineWidth: 5)
                    .padding(.bottom, 40)
                
                
                Image ("monkeyeats")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 336, height: 336)
                    .padding(.bottom, 20)
                
                Button {
                    withAnimation { self.backToMainScreen() }
                } label: {
                    Image("left")
                        .resizable()
                        .frame(width: 65, height: 65)
                }
            }
        }
        .statusBar(hidden: true)
    }
    
    private func backToMainScreen() {
        self.currentGameState = .mainScreen
    }
    
    private func restartGame() {
        self.currentGameState = .playing
    }
}

#Preview {
    GameOverView(currentGameState: .constant(GameState.gameOver))
}
