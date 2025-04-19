//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Susie Kim on 4/16/25.
//

import SwiftUI

struct Flag: View {
    var num: Int
    var countries: Array<String>
    
    var body: some View {
        Image(countries[num])
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var wrongAnswerText = ""
    
    @State private var numQuestions = 0
    @State private var finishedGame = false
    
    @State private var score = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 1.0, green: 0.8, blue: 0.5), location: 0.1),
                .init(color: Color(red: 1.0, green: 0.4, blue: 0.4), location: 0.4)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Flag(num: number, countries: countries)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("\(wrongAnswerText)\nYour score is \(score)")
        }
        .alert(scoreTitle, isPresented: $finishedGame) {
            Button("Start Over", action: {
                finishedGame = false
                endGame()
            })
        } message: {
            Text("You completed 8 questions!\nYour final score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            wrongAnswerText = ""
        } else {
            scoreTitle = "Wrong"
            wrongAnswerText = "That's the flag of \(countries[number])"
        }
        showingScore = true
        numQuestions += 1
        if(numQuestions == 8) {
            finishedGame = true
        }
    }
    
    func askQuestion() {
        if(numQuestions != 8) {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func endGame() {
        numQuestions = 0
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
