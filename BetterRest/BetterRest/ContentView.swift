//
//  ContentView.swift
//  BetterRest
//
//  Created by Susie Kim on 4/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute) // what TIME someone wants to wake up
                    .labelsHidden() // don't want the actual text label
                
                Text("Desired amount of sleep")
                    .font(.headline)
                
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                
                Text("Daily coffee intake")
                    .font(.headline)
                
                Stepper("\(coffeeAmount) coffee", value: $coffeeAmount, in: 1...20, step: 1)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
