//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andrew Emad on 14/06/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Button(action: {}, label: {
                Text("Add1")
                Text("Add2")
                Image(systemName: "pencil")
            })
        }
    }
}

#Preview {
    ContentView()
}
