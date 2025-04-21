//
//  ContentView.swift
//  BetterRest
//
//  Created by Susie Kim on 4/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now // current data & time
    
    var body: some View {
        // Text(Date.now, format: .dateTime.hour().minute())
        Text(Date.now.formatted(date: .long, time: .shortened))
    }
}

#Preview {
    ContentView()
}
