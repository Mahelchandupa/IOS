import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    Text("Square Game")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                        .padding(.bottom, 40)

                    VStack(spacing: 20) {
                        NavigationLink(destination: GameView()) {
                            buttonStyle(text: "Start Game", backgroundColor: .blue)
                        }

                        NavigationLink(destination: HighScoreView()) {
                            buttonStyle(text: "High Scores", backgroundColor: .green)
                        }

                        NavigationLink(destination: GuideView()) {
                            buttonStyle(text: "Guide", backgroundColor: .orange)
                        }
                    }

                    Spacer()
                }
                .padding()
            }
        }
    }

    private func buttonStyle(text: String, backgroundColor: Color) -> some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(backgroundColor)
            .cornerRadius(12)
            .shadow(color: backgroundColor.opacity(0.4), radius: 8, x: 0, y: 4)
            .padding(.horizontal, 16)
    }
}

#Preview {
    MenuView()
}