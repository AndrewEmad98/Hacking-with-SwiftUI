//
//  ContentView.swift
//  iExpense
//
//  Created by Andrew Emad on 04/11/2024.
//

import Observation
import SwiftUI

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name:String
    let type:String
    let cost: Double
}

@Observable
class Expenses {
    var items: [ExpenseItem] = [] {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(items){
                UserDefaults.standard.setValue(data, forKey: "expenses")
            }
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        if let savedItems = UserDefaults.standard.data(forKey: "expenses"), let expenses = try? decoder.decode([ExpenseItem].self, from: savedItems){
            self.items = expenses
        }
    }
}

struct ContentView: View {
    @State var isShowedAddItem = false
    @State private var expenses = Expenses()
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.cost, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: deleteItem)
            }.navigationTitle("iExpense")
            .toolbar() {
                Button("Add Expense", systemImage: "plus") {
                    isShowedAddItem.toggle()
                }
            }
            .sheet(isPresented: $isShowedAddItem) {
                AddView(expenses: self.expenses)
            }
        }
    }
    
    private func deleteItem(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
