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
        VStack(alignment: .leading){
            Text("HIGH SCORES")
                .font(.title)
                .bold()
            Text("\(highScore)")
            
        }
    }
}

#Preview {
    CreditView()
}
