//
//  GameDurationView.swift
//  ArcadeGameTemplate
//

import SwiftUI

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
        
    }
}

#Preview {
    GameDurationView(time: .constant(1000))
        .previewLayout(.fixed(width: 300, height: 100))
}
