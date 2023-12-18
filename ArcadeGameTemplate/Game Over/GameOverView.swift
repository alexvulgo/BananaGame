//
//  GameOverView.swift
//  ArcadeGameTemplate
//

import SwiftUI

struct GameOverView: View {
    
   
    @Binding var currentGameState: GameState
    let highScore = UserDefaults.standard.integer(forKey: "highScore")

    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack (alignment: .center) {
                
                Text ("GAME OVER")
                    .font(.system(size: 45))
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                    .glowBorder(color: Color("mybrown"), lineWidth: 5)
                    .padding(.bottom, 40)
                
                Text("HIGH SCORE")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                    .glowBorder(color: Color("mybrown"), lineWidth: 5)
                    .padding(.bottom, 5)
                Text("\(highScore)")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                    .glowBorder(color: Color("mybrown"), lineWidth: 5)
                
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
