//
//  ContentView.swift
//  WordScramble
//
//  Created by Susie Kim on 4/24/25.
//

import SwiftUI

struct ContentView: View {let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        
        List {
            Text("Static Row")
            
            ForEach(people, id: \.self) {
                Text($0)
            }
            
            Text("Static Row")
        }
    }
    
    func testStrings() {
        let word = "swift"
        let checker = UITextChecker()

        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
    }
}

#Preview {
    ContentView()
}
