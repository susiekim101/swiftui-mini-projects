//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Susie Kim on 5/1/25.
//

import SwiftUI

func nextQuestion() {
    
}

struct ContentView: View {
    @Binding var selectedNumber: Int?
    @Binding var numQuestions: Int
    @Binding var difficulty: Int
    var difficultyRange = [5, 10, 15]
    
    @State private var answer = 0
    @State private var randomNum: Int = 1
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    Text("\(selectedNumber ?? 2)")
                        .font(.largeTitle)
                    HStack {
                        Spacer()
                        Spacer()
                        Text("x")
                            .font(.largeTitle)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                    Text("\(randomNum)")
                        .font(.largeTitle)
                    
                    Rectangle()
                        .frame(width: 150, height: 2)
                }
                HStack {
                    TextField("", value: $answer, format: .number)
                        .keyboardType(.numberPad)
                        .font(.system(size: 40))
                        .frame(width: 150)
                        .background(Color(.secondarySystemBackground))
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                        .cornerRadius(12)
                }
                Spacer()
                Spacer()
            }
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    NavigationLink(destination: PreferencesView(selectedNumber: $selectedNumber, numQuestions: $numQuestions, difficulty: $difficulty)) {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(selectedNumber: .constant(2), numQuestions: .constant(5), difficulty: .constant(1))
}
