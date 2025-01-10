struct GuideView: View {
    var body: some View {
        VStack {
            Text("Game Guide")
                .font(.largeTitle)
                .padding()

            Text("""
                1. Click on two boxes.
                2 If the colors match, you score 1 point.
                3. If the colors don't match, the game is over.
                4. Score 4 points to win the game!
                """)
                   .font(.title)
                   .padding()

            Spacer()
        }
    }
}