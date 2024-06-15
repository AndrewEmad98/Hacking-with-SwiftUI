//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andrew Emad on 14/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    private var correctAnswer = Int.random(in: 0...2)
    
    @State private var playerScore = 0
    
    @State private var scoreAlert = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .init(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: .init(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],center: .top,startRadius: 200, endRadius: 700).ignoresSafeArea()

            VStack(spacing:30) {
                Spacer()
                Text("Guess the flag").font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing:15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0...2, id: \.self){ index in
                        Button(action: {
                            self.countryTapped(index)
                        }, label: {
                            Image(countries[index])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        })
                    }
                }.frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score is \(playerScore)").font(.title.bold()).foregroundStyle(.white)
                Spacer()
            }.padding()
            
        }.alert(scoreTitle, isPresented: $scoreAlert, actions:{
            Button("Ok") {
                countries = countries.shuffled()
            }
        },message: {
            Text("Your score is \(playerScore)")
        })
    }
    
    private func countryTapped(_ number: Int) {
        if number == correctAnswer {
            playerScore += 1
            scoreTitle = "Correct"
        }else {
            playerScore -= 1
            scoreTitle = "Wrong"
        }
        scoreAlert = true
    }
}

#Preview {
    ContentView()
}
