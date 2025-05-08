//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Susie Kim on 5/1/25.
//

import SwiftUI


struct ContentView: View {
    let selectedNumber: Int? = 2
    let numQuestions: Int? = 5
    let difficulty: Int? = 1
    var difficultyRange = [5, 10, 15]
    
    
    var body: some View {
        NavigationStack {
            Text("\(selectedNumber ?? 2)")
                .font(.largeTitle)
            
            Text("\(Int.random(in: 1...difficultyRange[difficulty ?? 0]))")
                .font(.largeTitle)
        }
        .toolbar {
            Button("Settings", systemImage: "setting")
        }
    }
}

#Preview {
    ContentView()
}
