//
//  MainScreen.swift
//  ArcadeGameTemplate
//

import SwiftUI

struct MainScreenView: View {
    
    @Binding var currentGameState: GameState
    var gameTitle: String = MainScreenProperties.gameTitle
    let accentColor: Color = MainScreenProperties.accentColor
    
    var body: some View {
        
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 16.0) {
                
                Spacer()
                
                Text("\(self.gameTitle)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(UIColor.black))
                
                Button {
                    withAnimation { self.startGame() }
                } label: {
                    Text("Play")
                        .padding()
                        .frame(maxWidth: 300)
                }
                .foregroundColor(.white)
                .background(Color(UIColor.systemYellow))
                .cornerRadius(10.0)
                
                
                
                Button {
                    withAnimation { self.startGame() }
                } label: {
                    Text("Credits")
                        .padding()
                        .frame(maxWidth: 300)
                }
                .foregroundColor(.white)
                .background(Color(UIColor.systemYellow))
                .cornerRadius(10.0)
                
                Spacer()
            }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .padding()
                .statusBar(hidden: true)
        }
    }
    
    private func startGame() {
        print("- Starting the game...")
        self.currentGameState = .playing
    }
}

#Preview {
    MainScreenView(currentGameState: .constant(GameState.mainScreen))
}
