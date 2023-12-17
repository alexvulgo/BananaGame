//
//  GameScoreView.swift
//  ArcadeGameTemplate
//

import SwiftUI

/**
 * # GameScoreView
 * Custom UI to present how many points the player has scored.
 *
 * Customize it to match the visual identity of your game.
 */

struct GameScoreView: View {
    @Binding var score: Int

    var body: some View {
        
        HStack{
            
            Spacer()
            
            Text("\(score)")
                .font(.title)
            
        }
        .frame(maxWidth: 200)
        .padding(24)
        .foregroundColor(.white)
        //.background(Color(.systemYellow))
       // .cornerRadius(10)
    }
}

#Preview {
    GameScoreView(score: .constant(100)
)
        .previewLayout(.fixed(width: 300, height: 100))
}

