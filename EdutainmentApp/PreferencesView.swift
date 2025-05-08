//
//  PreferencesView.swift
//  EdutainmentApp
//
//  Created by Susie Kim on 5/3/25.
//

import SwiftUI
struct ButtonGridView: View {
    @Binding var selectedNumber: Int?
    
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(1...12, id: \.self) { number in
                Button(action: {
                    if (selectedNumber == number) {
                        selectedNumber = nil
                    } else {
                        selectedNumber = number
                    }
                }) {
                    Text("\(number)")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(selectedNumber == number ? .red : .blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}

struct PreferencesView: View {
    var timesTable = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var questions = [5, 10, 20]
    var levelDifficuly = ["easy", "medium", "hard"]
    @State private var selectedNumber: Int? = nil
    @State private var numQuestions = 0;
    @State private var difficulty = 0;
    
    
    var body: some View {
        NavigationStack {
            Spacer()
            Spacer()
            VStack {
                Text("Select Times Table")
                    .font(.headline)
                ButtonGridView(selectedNumber: $selectedNumber)
            }
            
            Spacer()
            VStack {
                Text("Number of questions")
                    .font(.headline)
                Picker("Number of questions", selection: $numQuestions) {
                    ForEach(0..<3) {
                        Text("\(questions[$0])")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            
            Spacer()
            VStack {
                Text("Difficulty Level")
                    .font(.headline)
                Picker("", selection: $difficulty) {
                    ForEach(0..<3) {
                        Text("\(levelDifficuly[$0])")
                    }
                }
            }
            Spacer()
            Spacer()
            /*NavigationLink(destination: QuizView(selectedNumber: selectedNumber, numQuestions: numQuestions, difficulty: difficulty)) {
                Text("Start")
                    .frame(width: 150, height: 40)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }*/

        }
    }
}

#Preview {
    PreferencesView()
}
