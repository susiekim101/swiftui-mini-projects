//
//  ContentView.swift
//  RPSTrainingApp
//
//  Created by Susie Kim on 4/20/25.
//

import SwiftUI

struct computerText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 150, height: 75)
            .padding(15)
            .background(Color(red: 254/255, green: 250/255, blue: 224/255))
            .clipShape(.rect(cornerRadius: 20))
            .background(.ultraThinMaterial)
    }
}

struct button: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 150, height: 40)
            .background(Color(red: 250/255, green: 237/255, blue: 205/255))
            .clipShape(.capsule)
            .font(.title3)
            .foregroundStyle(.black)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(computerText())
    }
    func buttonStyle() -> some View {
        modifier(button())
    }
}


struct ContentView: View {
    let options = ["rock", "paper", "scissors"]
    let win = ["paper", "scissors", "rock"]
    let lose = ["scissors", "rock", "paper"]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var playerChoice = ""
    @State private var numQuestions = 0
    @State private var finishedGame = false
    
    @State private var score = 0
    
    func updateScore(_ player: String) {
        if(shouldWin && (player == win[appChoice])) {
            score += 1
        }
        else if(!shouldWin && (player == lose[appChoice])) {
            score += 1
        }
    }
    
    func nextQuestion() {
        numQuestions += 1
        if(numQuestions != 10) {
            appChoice = Int.random(in: 0...2)
            shouldWin = Bool.random()
        } else {
            finishedGame = true
        }
    }
    
    func endGame() {
        score = 0
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 233/255, green: 237/255, blue: 201/255), location: 0.2),
                .init(color: Color(red: 204/255, green: 213/255, blue: 174/255), location: 0.5)],
                center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
                                   
            VStack(spacing: 20) {
                VStack(){
                    Text("We choose")
                    Text("\(options[appChoice])")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .titleStyle()
                
                VStack(){
                    Text("You must try to")
                    Text("\(shouldWin ? "win" : "lose")")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .titleStyle()
                
                VStack(){
                    Text("Select your answer")
                    Button("rock") {
                        updateScore("rock")
                        nextQuestion()
                    }
                        .buttonStyle()
                    Button("paper") {
                        updateScore("paper")
                        nextQuestion()
                    }
                        .buttonStyle()
                    Button("scissors") {
                        updateScore("scissors")
                        nextQuestion()
                    }
                        .buttonStyle()
                }
                
                VStack() {
                    Text("Score: \(score)")
                }
            }
            .alert("Congratulations!", isPresented: $finishedGame) {
                Button("Start Over") {
                    finishedGame = false
                    endGame()
                }
            } message: {
                Text("You correctly answered \(score) out of 10 questions")
            }
        }
    }
}

#Preview {
    ContentView()
}
