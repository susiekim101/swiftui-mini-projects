 //
//  ContentView.swift
//  Moonshot
//
//  Created by Susie Kim on 5/7/25.
//

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView: View {
    @State private var showingGrid = true
    var layoutText: String {
        showingGrid ? "List View" : "Grid View"
    }
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    // Adaptive column layout
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout()
                } else {
                    ListLayout()
                }
            }
            .toolbar {
                Button(layoutText) {
                    showingGrid.toggle()
                }
                .foregroundStyle(.white.opacity(0.8))
            }
            .navigationTitle("Moonshot")
        }
    }
}

#Preview {
    ContentView()
}
