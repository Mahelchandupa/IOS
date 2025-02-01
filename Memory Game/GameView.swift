import SwiftUI

// enum GameLevel: Int {
//     case twoByTwo = 2
//     case threeByThree = 3
//     case fourByFour = 4
    
//     var timeLimit: Int {
//         switch self {
//         case .twoByTwo: return 30
//         case .threeByThree: return 45
//         case .fourByFour: return 60
//         }
//     }
    
//     var memorizationTime: Int {
//         switch self {
//         case .twoByTwo: return 3
//         case .threeByThree: return 4
//         case .fourByFour: return 5
//         }
//     }
    
//     var highScoreKey: String {
//         switch self {
//         case .twoByTwo: return "highScores_2x2"
//         case .threeByThree: return "highScores_3x3"
//         case .fourByFour: return "highScores_4x4"
//         }
//     }
// }

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentLevel: GameLevel = .twoByTwo
    @State private var colorPalette: [Color] = [.red, .red, .green, .green, .blue, .blue, .yellow, .yellow, 
                                               .orange, .orange, .purple, .purple, .pink, .pink, .cyan, .cyan]
    @State private var randomizedColors: [Color] = []
    @State private var currentColors: [Color] = []
    @State private var selectedTiles: [(position: Int, color: Color)] = []
    @State private var matchedTiles: Set<Int> = []
    @State private var inactiveTiles: Set<Int> = []
    @State private var currentScore: Int = 0
    @State private var totalScore: Int = 0
    @State private var isGameOver: Bool = false
    @State private var memorizationTime: Int = 3
    @State private var remainingTime: Int = 30
    @State private var timer: Timer?
    @State private var showLevelCompleteAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("Memory Game - Level \(currentLevel.rawValue)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            HStack {
                Text("Score: \(totalScore)")
                    .font(.title)
                Spacer()
                Text("Time: \(remainingTime)s")
                    .font(.title)
                    .foregroundColor(remainingTime <= 10 ? .red : .primary)
            }
            .padding()
            
            if memorizationTime > 0 {
                Text("Memorize the colors! (\(memorizationTime)s)")
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding()
            }
            
            if !randomizedColors.isEmpty {
                Grid(alignment: .center, horizontalSpacing: 10, verticalSpacing: 10) {
                    ForEach(0..<currentLevel.rawValue, id: \.self) { row in
                        GridRow {
                            ForEach(0..<currentLevel.rawValue, id: \.self) { column in
                                let tileIndex = row * currentLevel.rawValue + column
                                let isSelected = selectedTiles.contains { $0.position == tileIndex }
                                let isMatched = matchedTiles.contains(tileIndex)
                                let displayColor = isMatched || isSelected ? 
                                    randomizedColors[tileIndex] : currentColors[tileIndex]
                                
                                Rectangle()
                                    .foregroundColor(displayColor)
                                    .frame(height: CGFloat(350 / currentLevel.rawValue))
                                    .cornerRadius(10)
                                    .overlay(
                                        Button(action: {
                                            handleTileTap(index: tileIndex)
                                        }) {
                                            Color.clear
                                        }
                                        .disabled(inactiveTiles.contains(tileIndex) || 
                                                 selectedTiles.count == 2 || 
                                                 memorizationTime > 0)
                                    )
                            }
                        }
                    }
                }
                .padding()
            }
            
            if isGameOver {
                Button("Try Again") {
                    startNewGame()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .onAppear(perform: startNewGame)
        .alert(isPresented: $showLevelCompleteAlert) {
            Alert(
                title: Text("Level Complete!"),
                message: Text("Would you like to proceed to the next level?"),
                primaryButton: .default(Text("Yes")) {
                    proceedToNextLevel()
                },
                secondaryButton: .cancel(Text("No")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .alert(isPresented: .constant(isGameOver && !showLevelCompleteAlert)) {
            Alert(
                title: Text("Game Over"),
                message: Text("Time's up! Your final score: \(totalScore)"),
                dismissButton: .default(Text("Back to Menu")) {
                    saveHighScore()
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    func startNewGame() {
        let gridSize = currentLevel.rawValue * currentLevel.rawValue
        let colors = Array(colorPalette.prefix(gridSize))
        randomizedColors = colors.shuffled()
        currentColors = randomizedColors
        selectedTiles.removeAll()
        matchedTiles.removeAll()
        inactiveTiles.removeAll()
        currentScore = 0
        isGameOver = false
        memorizationTime = currentLevel.memorizationTime
        remainingTime = currentLevel.timeLimit
        
        // Start memorization timer
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if memorizationTime > 0 {
                memorizationTime -= 1
            } else {
                timer.invalidate()
                currentColors = Array(repeating: .gray, count: gridSize)
                startGameTimer()
            }
        }
    }
    
    func startGameTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer?.invalidate()
                isGameOver = true
            }
        }
    }
    
    func handleTileTap(index: Int) {
        guard !inactiveTiles.contains(index) else { return }
        
        let color = randomizedColors[index]
        selectedTiles.append((position: index, color: color))
        currentColors[index] = color
        inactiveTiles.insert(index)
        
        if selectedTiles.count == 2 {
            let firstTile = selectedTiles[0]
            let secondTile = selectedTiles[1]
            
            if firstTile.color == secondTile.color {
                matchedTiles.insert(firstTile.position)
                matchedTiles.insert(secondTile.position)
                currentScore += 1
                totalScore += 1
                
                if matchedTiles.count == currentLevel.rawValue * currentLevel.rawValue {
                    timer?.invalidate()
                    showLevelCompleteAlert = true
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    currentColors[firstTile.position] = .gray
                    currentColors[secondTile.position] = .gray
                    inactiveTiles.remove(firstTile.position)
                    inactiveTiles.remove(secondTile.position)
                }
            }
            selectedTiles.removeAll()
        }
    }
    
    func proceedToNextLevel() {
        saveHighScore()
        switch currentLevel {
        case .twoByTwo:
            currentLevel = .threeByThree
        case .threeByThree:
            currentLevel = .fourByFour
        case .fourByFour:
            presentationMode.wrappedValue.dismiss()
            return
        }
        startNewGame()
    }
    
    func saveHighScore() {
        guard totalScore > 0 else { return }
        
        let key = currentLevel.highScoreKey
        var highScores = UserDefaults.standard.getHighScores(forKey: key)
        
        if !highScores.contains(totalScore) {
            highScores.append(totalScore)
            highScores.sort(by: >)
            
            if highScores.count > 10 {
                highScores = Array(highScores.prefix(10))
            }
            
            UserDefaults.standard.setHighScores(highScores, forKey: key)
        }
    }
}
#Preview {
    GameView()
}
