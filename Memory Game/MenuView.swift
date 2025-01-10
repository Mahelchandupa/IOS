import SwiftUI

struct MenuView: View {
    @State private var showGame = false
    @State private var = showHighScores = false
    @State private var showGuide = false
    @State private var highScore = 0

    var body: some View {
        NavigationView {
            VStack {
                Text("Square Game")
                    .font(.largeTitle)
                    .padding(.top)
                
                Spacer()

                Button(action: {
                    showGame = true
                }) {
                    Text("Start Game")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                Button(action: {
                    showHighScores = true
                }) {
                    Text("High Scores")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                Button(action: {
                    showGuide = true
                }) {
                    Text("How to Play")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                Button(action: {
                    exit(0)
                }) {
                    Text("Exit")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(NavigationView("", destination: GameView(highScore: $highScore), isActive: $showGame).hidden())
            .background(NavigationView("", destination: HighScoresView(highScore: highScore), isActive: $showHighScores).hidden())
            .background(NavigationView("", destination: GuideView(), isActive: $showGuide).hidden())
        }
    }
}

#Preview {
    MenuView()
}