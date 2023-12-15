//
//  GameDurationView.swift
//  ArcadeGameTemplate
//

import SwiftUI

/**
 * # GameDurationView
 * Custom UI to present how many seconds have passed since the beginning of the gameplay session.
 *
 * Customize it to match the visual identity of your game.
 */



struct GameDurationView: View {
    
    
    @Binding var time: TimeInterval
    
    var lifeIndexCount = 0
    
    var body: some View {
        
        
        
        VStack {
            Image("banana222")
                .resizable()
                .aspectRatio(contentMode: .fit)
               
            
            Image("banana222")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            
            Image("banana222")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
           
        }
        .frame(maxWidth: 100)
        .padding(24)
        .foregroundColor(.white)
        //.background(Color(.systemYellow))
        //.cornerRadius(10)
    }
}

#Preview {
    GameDurationView(time: .constant(1000))
        .previewLayout(.fixed(width: 300, height: 100))
}
