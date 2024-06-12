//
//  ContentView.swift
//  UnitConversion
//
//  Created by Andrew Emad on 12/06/2024.
//

import SwiftUI

struct ContentView: View {
    //MARK: - State properties
    @State private var selectedUnit: String = "Temperature"
    
    @State private var selectedFromSubUnit: String = "Celsius"
    @State private var selectedToSubUnit: String = "Celsius"
    
    @State private var fromSubUnit: (any Unitable)? = nil
    @State private var toSubUnit: (any Unitable)? = nil
    
    @State private var fromValue: Double = 0.0
    @FocusState private var fromTextFieldFocus: Bool
    private var toValue: String {
        //MARK: - TODO
        guard let fromSubUnit = fromSubUnit, let toSubUnit = toSubUnit else {
            return "0"
        }
        /*
         parse the data from "fromSubUni" by its operation to "toSubUnit.name" and
         return the value here
         */
        return "0"
    }
    
    //MARK: - properties
    let units = UnitFactory.shared.getAvailableUnits()
    var body: some View {
        NavigationStack {
            Form {
                Section("Choose your unit?"){
                    Picker("Select a unit", selection: $selectedUnit) {
                        ForEach(units, id: \.name){
                            Text($0.name).bold()
                        }
                    }.pickerStyle(.automatic)
                        .onChange(of: selectedUnit) {
                            if let selectedUnitData = units.first(where: { $0.name == selectedUnit }) {
                                fromSubUnit = selectedUnitData.subUnits[0] as? any Unitable
                                toSubUnit = selectedUnitData.subUnits[0] as? any Unitable
                                selectedToSubUnit = selectedUnitData.subUnits[0].unitName
                                selectedFromSubUnit = selectedUnitData.subUnits[0].unitName
                            }
                        }
                }
                
                Section {
                    HStack(alignment: .center){
                        Section {
                            Text("From:")
                            TextField("", value: $fromValue, format: .number)
                                .keyboardType(.decimalPad)
                                .focused($fromTextFieldFocus)
                        }
                        Spacer()
                        Section {
                            Text("to:")
                            Text("\(toValue)")
                        }

                    }
                }
                Section {
                    if let selectedUnitData = units.first(where: { $0.name == selectedUnit }) {
                        Section {
                            Picker("Select a from unit", selection: $selectedFromSubUnit) {
                                ForEach(selectedUnitData.subUnits, id: \.unitName) { subUnit in
                                    Text(subUnit.unitName).tag(subUnit.unitName)
                                }
                            }
                            .pickerStyle(.automatic)
                            
                            Picker("Select a to unit", selection: $selectedToSubUnit) {
                                ForEach(selectedUnitData.subUnits, id: \.unitName) { subUnit in
                                    Text(subUnit.unitName).tag(subUnit.unitName)
                                }
                            }
                            .pickerStyle(.automatic)
                        }
                    }
                }
            
            }
            .navigationTitle("Unit Converter")
            .toolbar{
                if fromTextFieldFocus {
                    Button("Done") {
                        fromTextFieldFocus = !fromTextFieldFocus
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


