struct GameView: View {
    private let gridSize = 3
    @State private var redIdices = Set<Int>()
    @State private var greenIdices = Set<Int>()
    @State private var blueIdices = Set<Int>()
    @State private var yellowIdices = Set<Int>()
    @State private var disabledIndices = Set<Int>()
    @State private var selectedIndices = [Int]()
    @State private var score = 0
    @Blinding var highScore: Int
    @State private var message = ""
    @State private var gameOver = false

    var body: some View {
        VStack {
            Text("Score: \(score)")
                .font(.title2)
                .padding(.bottom)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize)) {
                ForEach(0..<gridSize * gridSize, id: \.self) { index in
                    Rectangle()
                        .frame(width: 100, height: 100)
                        .cornerRadius(8)
                        .foregroundColor(disabledIndices.contains(index) ? Color.gray : colorForIndex(index))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .onTapGesture {
                            if !disabledIndices.contains(index) {
                                handleBoxClick(index)
                            }
                        }
                        .disabled(disabledIndices.contains(index)) // Disable if already matched
                }
            }
            .padding()

            if gameOver {
                Text("Game Over")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding(.top)

                Button("Restart") {
                    resetGame()
                }
                .padding()
                    
            }
            .onAppear {
                assignRandomColors()
            }
        }

        private func assignRandomColors() {
            let allIndices = Array(0..<gridSize * gridSize)
            let randomIndices = allIndices.shuffled().prefix(8)

            redIdices = Set(randomIndices.prefix(2))
            greenIdices = Set(randomIndices.dropFirst(2).prefix(2))
            blueIdices = Set(randomIndices.dropFirst(4).prefix(2))
            yellowIdices = Set(randomIndices.dropFirst(6).prefix(2))

            disabledIndices = []
            selectedIndices = []
            score = 0
            message = ""
            gameOver = false
        }

        private func colorForIndex(_ index: Int) -> Color {
            if redIdices.contains(index) {
                return .red
            } else if greenIdices.contains(index) {
                return .green
            } else if blueIdices.contains(index) {
                return .blue
            } else if yellowIdices.contains(index) {
                return .yellow
            } else {
                return .gray
            }
        }

        private func handleBoxClick(_ index: Int) {
            selectedIndices.append(index)

            if selectedIndices.count == 2 {
                let firstIndex = selectedIndices[0]
                let secondIndex = selectedIndices[1]

                if colorForIndex(firstIndex) == colorForIndex(secondIndex) {
                    score += 1
                    disabledIndices.insert(firstIndex)
                    disabledIndices.insert(secondIndex)

                    if score > highScore {
                        highScore = score
                    }

                    if score = 4 {
                        message = "You win!"
                        gameOver = true
                    }
                } else {
                    message = "Game Over! Try again."
                    gameOver = true
                }

                selectedIndices.removeAll()
            }

            private func resetGame() {
                assignRandomColors()
            }
        }
    }
}