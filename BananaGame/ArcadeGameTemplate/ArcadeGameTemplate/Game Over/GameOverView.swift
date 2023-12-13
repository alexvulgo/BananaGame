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
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(uiColor: UIColor.systemYellow))
                .padding(.bottom, 100)
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button {
                        withAnimation { self.backToMainScreen() }
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    .background(Circle().foregroundColor(Color(uiColor: UIColor.systemYellow))
                        .frame(width: 100, height: 100, alignment: .center))
                    
                    Spacer()
                    
                    Button {
                        withAnimation { self.restartGame() }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    .background(Circle().foregroundColor(Color(uiColor: UIColor.systemYellow)).frame(width: 100, height: 100, alignment: .center))
                    
                    Spacer()
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
