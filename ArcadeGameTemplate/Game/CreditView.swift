//
//  CreditView.swift
//  ArcadeGameTemplate
//
//  Created by Alessandro Esposito Vulgo Gigante on 15/12/23.
//

import SwiftUI

struct CreditView: View {
    
    let highScore = UserDefaults.standard.integer(forKey: "highScore")
    
    var body: some View {
        
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(alignment: .center){
                Text("HIGH SCORE")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                    .glowBorder(color: Color("mybrown"), lineWidth: 5)
                    .padding(.bottom, 10)
                Text("\(highScore)")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                    .glowBorder(color: Color("mybrown"), lineWidth: 5)
            }
            .statusBar(hidden: true)
        }
    }
}

#Preview {
    CreditView()
}
