//
//  CreditView.swift
//  ArcadeGameTemplate
//
//  Created by Alessandro Esposito Vulgo Gigante on 15/12/23.
//

import SwiftUI

struct CreditView: View {
    
    let loadData = UserDefaults.standard
    
    var body: some View {
        VStack(alignment: .leading){
            Text("HIGH SCORES")
                .font(.title)
                .bold()
            
           
        }
    }
}

#Preview {
    CreditView()
}
