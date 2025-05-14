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
    @Environment(\.dismiss) private var dismiss
    
    var timesTable = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var questions = [5, 10, 20]
    var levelDifficulty = ["easy", "medium", "hard"]
    @Binding var selectedNumber: Int?
    @Binding var numQuestions: Int
    @Binding var difficulty: Int
    @State private var localSelectedNumber: Int? = nil
    @State private var localNumQuestions: Int = 0
    @State private var localDifficulty: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Spacer()
                VStack {
                    Text("Select Times Table")
                        .font(.headline)
                    ButtonGridView(selectedNumber: $localSelectedNumber)
                }
                
                Spacer()
                VStack {
                    Text("Number of questions")
                        .font(.headline)
                    Picker("Number of questions", selection: $localNumQuestions) {
                        ForEach(0..<questions.count, id: \.self) { index in
                            Text("\(questions[index])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                
                Spacer()
                VStack {
                    Text("Difficulty Level")
                        .font(.headline)
                    Picker("", selection: $localDifficulty) {
                        ForEach(levelDifficulty.indices, id: \.self) { index in
                            Text("\(levelDifficulty[index])")
                        }
                    }
                }
                Spacer()
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    Button("Done") {
                        selectedNumber = localSelectedNumber
                        numQuestions = localNumQuestions
                        difficulty = localDifficulty
                        dismiss()
                    }
                }
            }
        }
    }
    
    init(selectedNumber: Binding<Int?>, numQuestions: Binding<Int>, difficulty: Binding<Int>) {
        self._selectedNumber = selectedNumber
        self._numQuestions = numQuestions
        self._difficulty = difficulty
    }
}

#Preview {
    PreferencesView(selectedNumber: .constant(2), numQuestions: .constant(1), difficulty: .constant(1))
}
