//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Güray Gül on 28.09.2023.
//

import SwiftUI

struct FlagImage: View {
    
    let name: String
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var possibleMoves = AllPossibleMoves.shuffled()
    static let AllPossibleMoves = ["🪨", "📃", "✂️"]
    
    @State private var currentSelection = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showFinalScore = false
    @State private var currentScore = 0
    @State private var questionCounter = 1
    
    var body: some View{
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.5, blue: 0.5), location: 0.3),
                .init(color: Color(red: 0.1, green: 0.10, blue: 0.3), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Rock, Paper & Scissors")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the right answer")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 30))
                        
                        Text("Bot's Selection is: \(possibleMoves[currentSelection])")
                            .font(.system(size: 30))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            HStack {
                                Text("Select: \(possibleMoves[number])")
                                    .font(.system(size: 40))
                                    }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is: \(currentScore)")
        }
        
        .alert("Game Over", isPresented: $showFinalScore) {
            Button("Reset the game", action: newGame)
        } message: {
            Text("Your final score was: \(currentScore)")
        }
        
    }
    
    func flagTapped(_ number: Int){
        showingScore = true
        
        if possibleMoves[number] == "📃" && possibleMoves[currentSelection] == "🪨"{
            scoreTitle = "Correct"
            currentScore += 1
        } else if possibleMoves[number] == "✂️" && possibleMoves[currentSelection] == "📃" {
            scoreTitle = "Correct"
            currentScore += 1
        } else if possibleMoves[number] == "🪨" && possibleMoves[currentSelection] == "✂️" {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong!!!"
            currentScore -= 1
        }
        
        
        
        if questionCounter == 8 {
            showFinalScore = true
            
        }   else {
            showingScore = true
        }

    }
    
    func askQuestion(){
        
        possibleMoves.shuffle()
        currentSelection = Int.random(in: 0...2)
        questionCounter += 1
    }
    
        func newGame(){
            questionCounter = 0
            currentScore = 0
            possibleMoves = Self.AllPossibleMoves
            askQuestion()
        }
    
    
    }


#Preview {
    ContentView()
}
