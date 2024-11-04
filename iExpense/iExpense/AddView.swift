//
//  AddView.swift
//  iExpense
//
//  Created by Andrew Emad on 04/11/2024.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var cost = 0.0
    let types = ["Business", "Personal"]
    
    var expenses: Expenses
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Select your type", selection: $type) {
                    ForEach(types, id: \.self){ type in
                        Text(type)
                    }
                }
                TextField("Cost", value: $cost, formatter: currencyFormatter)
                    .keyboardType(.decimalPad)
            }.navigationTitle("Add new Expense")
             .toolbar(){
                 Button("Save") {
                     let item = ExpenseItem(name: self.name, type: self.type, cost: self.cost)
                     expenses.items.append(item)
                     dismiss()
                 }
             }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
