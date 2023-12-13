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
        
        HStack {
            Image(systemName: "star.fill")
                .font(.headline)
            Spacer()
            Text("\(score)")
                .font(.headline)
        }
        .frame(maxWidth: 100)
        .padding(24)
        .foregroundColor(.white)
        .background(Color(.systemYellow))
        .cornerRadius(10)
    }
}

#Preview {
    GameScoreView(score: .constant(100))
        .previewLayout(.fixed(width: 300, height: 100))
}

