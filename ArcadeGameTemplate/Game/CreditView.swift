//
//  CreditView.swift
//  ArcadeGameTemplate
//
//  Created by Alessandro Esposito Vulgo Gigante on 15/12/23.
//

import SwiftUI

struct CreditView: View {
    
    @Binding var score: Int
    
    var body: some View {
        VStack(alignment: .leading){
            Text("HIGH SCORES")
                .font(.title)
                .bold()
            
            Text("ciao")
        }
    }
}

#Preview {
    CreditView(score: .constant(100))
        .previewLayout(.fixed(width: 300, height: 100))
}
