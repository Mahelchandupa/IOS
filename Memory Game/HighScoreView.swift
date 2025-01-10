struct HighScoresView: View {
    let highScore: Int

    var body: some View {
        VStack {
            Text("High Scores")
                .font(.largeTitle)
                .padding()

            Text("Your high score is \(highScore)")
                .font(.title)
                .padding()

            Spacer()
        }
    }
}