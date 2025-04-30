//
//  ContentView.swift
//  WordScramble
//
//  Created by Susie Kim on 4/24/25.
//

import SwiftUI

struct ContentView: View {let people = ["Finn", "Leia", "Luke", "Rey"]
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false // no alsert by default
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack{
                            // Uses built in Apple's SF Symbols
                            Image(systemName: "\(word.count).circle")
                            Text("\(word)")
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            // when this view is shown, automatically run this function
            .onAppear(perform: startGame)
            // alert if showingError is true, which is triggered by wordError
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
            .toolbar{
                Button("Restart", action: startGame)
            }
            Text("Score:")
                .font(.title.weight(.semibold))
            Text("\(score)")
                .font(.title)
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isLong(word: answer) else {
            wordError(title: "Word is too short", message: "Select a longer word!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You cannot spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You cannot make up words.")
            return
        }
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        calcScore(word: answer);
        
        // Responds to unresolvable problems very clearly (when the app cannot locate the file, file does not exist, cannot load the file, etc)
        // When it locates an error, it will unconditionally crash the app
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = [];
                score = 0;
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    // Determine whether the world has been used before
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        // Get a copy of our root word so we can modify it freely
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else { // pos was nil
                return false
            }
        }
        return true
    }
    
    /*
     UI text checker to scan strings for misspelled words
     Use a NSRange to span the entire length of our string
     Call RangeMiseplledWord on our textChecker
     When it finishes, give another NsRange where the misspelled word is
     If the word is OK, returns NS not found as location
     */
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isLong(word: String) -> Bool {
        if(word.count >= 3) { return true }
        return false;
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func calcScore(word: String) {
        var length = word.count;
        score += length * 100
    }
}

#Preview {
    ContentView()
}
