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
            
            VStack {
                Text ("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 50)
                    .glowBorder(color: Color("mybrown"), lineWidth: 5)
                
                Image ("monkeyeats")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 336, height: 336)
                    .clipped()
                    .padding(.bottom, 50)
                
                HStack(alignment: .center) {
                    Button {
                        withAnimation { self.backToMainScreen() }
                    } label: {
                        Image("left")
                            .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .scaleEffect(1.5)
                    }
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
