//
//  AstronautView.swift
//  Moonshot
//
//  Created by Andrew Emad on 11/11/2024.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
         
    }
}

#Preview {
    let astronuts: [String: Astronaut] = Bundle.main.fetch(file:"astronauts.json")
    return AstronautView(astronaut: astronuts.first!.value).preferredColorScheme(.dark)
}
