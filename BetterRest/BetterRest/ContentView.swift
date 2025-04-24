//
//  ContentView.swift
//  BetterRest
//
//  Created by Susie Kim on 4/21/25.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = "10:38 PM"
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    VStack(alignment: .center, spacing: 10) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .onChange(of: wakeUp, calculateBedtime)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                            .padding(.horizontal, 30)
                            .onChange(of: sleepAmount, calculateBedtime)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Daily coffee intake")
                            .font(.headline)
                        
                        Picker("^[\(coffeeAmount + 1) cup](inflect: true)", selection: $coffeeAmount) {
                            ForEach(1..<21) {
                                Text("\($0)")
                            }
                        }
                        .padding(.horizontal, 30)
                        .onChange(of: coffeeAmount, calculateBedtime)
                    }
                    
                    Section {
                        Text("Your suggested bedtime is ")
                            .font(.headline)
                        
                        Text("\(alertMessage)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                }
                
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
          
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
