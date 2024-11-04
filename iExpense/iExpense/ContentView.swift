//
//  ContentView.swift
//  iExpense
//
//  Created by Andrew Emad on 04/11/2024.
//

import Observation
import SwiftUI


struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("hello second sheet")
        Button("dismiss"){
            dismiss()
        }
    }
}

@Observable
class User {
    var firstName:String = "Andrew"
    var lastName: String = "Emad"
}

struct ContentView: View {
    @State private var isPresented = false
    @State private var user = User()
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            TextField("Your first name is", text: $user.firstName)
            TextField("Your last name is", text: $user.lastName)
            Button("Confirm") {
                isPresented.toggle()
            }
        }
        .padding()
        .sheet(isPresented: $isPresented, content: {
            SecondView()
        })
    }
}

#Preview {
    ContentView()
}
