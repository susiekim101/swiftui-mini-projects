//
//  ContentView.swift
//  ConversionApp
//
//  Created by Susie Kim on 4/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = 0.0
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    @FocusState private var inputIsFocused: Bool
    
    let units = [UnitLength.millimeters, UnitLength.centimeters, UnitLength.meters, UnitLength.kilometers, UnitLength.inches, UnitLength.feet, UnitLength.yards, UnitLength.miles]
    
    var calc: Measurement<UnitLength> {
        let initialLength = Measurement(value: inputNumber, unit: units[inputUnit])
        let finalLength = initialLength.converted(to: units[outputUnit])
        return finalLength
    }
    
    var format: MeasurementFormatter {
        let formatted = MeasurementFormatter()
        formatted.unitStyle = .long
        formatted.unitOptions = .providedUnit
        return formatted
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Enter your input values") {
                    TextField("\(inputUnit)", value: $inputNumber, format: .number.precision(.fractionLength(0...5)))
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Initial Unit", selection: $inputUnit) {
                        ForEach(0..<units.count, id: \.self) {
                            let inputString = format.string(from: units[$0])
                            Text("\(inputString)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Picker("Target Unit", selection: $outputUnit) {
                        ForEach(0..<units.count, id: \.self) {
                            let outputString = format.string(from: units[$0])
                            Text("\(outputString)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("Conversion") {
                    Text("\(format.string(from: calc))")
                }
            }
            .navigationTitle("Length Conversion")
            .toolbar {
                if inputIsFocused {
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
