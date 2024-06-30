//
//  ContentView.swift
//  BetterRest
//
//  Created by Andrew Emad on 19/06/2024.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUpDate = Self.defaultWakeUp
    @State private var sleepHours = 8.0
    @State private var coffee = 1
    @State private var showAlert = false
    @State private var alertTitle = "Error"
    @State private var alertMessage = "Something went wrong"
    
    static var defaultWakeUp: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading , spacing: 2) {
                    Text("when do you want to wake up?").bold()
                    DatePicker("wake up", selection: $wakeUpDate, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading , spacing: 2) {
                    Text("Desired amount of sleep").bold()
                    Stepper("\(sleepHours.formatted())", value: $sleepHours,in: 4...12,step: 0.25)
                }

                VStack(alignment: .leading , spacing: 2) {
                    Text("Daily coffee intake").bold()
                    Stepper(coffee == 1 ? "1 cup" : "\(coffee) cups", value: $coffee, in: 1...20)
                }
                
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate",action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Ok") {
                    showAlert = false
                }
            } message: {
                Text(alertMessage)
            }
        }
        
    }
    
    private func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try BestRestModel(configuration: config)
            let dateComponents = Calendar.current.dateComponents([.hour,.minute], from: wakeUpDate)
            let hour = (dateComponents.hour ?? 0) * 60 * 60
            let minute = (dateComponents.minute ?? 0) * 60
            let prediction = try model.prediction(input: .init(wake: Double(hour + minute), estimatedSleep: sleepHours, coffee: Double(coffee)))
            let sleepTime = wakeUpDate - prediction.actualSleep
            alertTitle = "Your ideal bed time is..."
            alertMessage = "\(sleepTime.formatted(date: .omitted, time: .shortened))"
        }catch {
            alertTitle = "Error"
            alertMessage = "Something went wrong"
        }
        showAlert = true
    }
}

#Preview {
    ContentView()
}
