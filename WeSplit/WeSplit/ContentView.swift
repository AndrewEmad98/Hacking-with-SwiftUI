//
//  ContentView.swift
//  WeSplit
//
//  Created by Andrew Emad on 07/06/2024.
//

import SwiftUI

struct ContentView: View {
    //MARK: - state properties
    @State private var totalCheckAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var selectedTipPercentage = 5
    @FocusState private var isAmountFocused:Bool
    private var totalPersonAmount: Double {
        let tip = Double(selectedTipPercentage) / 100.0
        let totalAmount = totalCheckAmount + (totalCheckAmount * tip)
        return totalAmount / Double(numberOfPeople)
    }
    //MARK: - data source
    private let tips = [5,10,15,20,25]
    private let currencyFormat = Locale.current.currency?.identifier ?? "USD"
    //MARK: - UI
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $totalCheckAmount, format: .currency(code: currencyFormat), prompt: Text("Amount"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2...100, id: \.self){
                            Text("\($0) people")
                        }
                    }
                }
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $selectedTipPercentage) {
                        ForEach(tips, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section {
                    Text(totalPersonAmount, format: .currency(code: currencyFormat))
                }
            }
            .navigationTitle("We split")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                if isAmountFocused {
                    Button("Done") {
                        isAmountFocused = !isAmountFocused
                    }
                }
            }
        }
        
    }
}

//MARK: - Canvas Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
