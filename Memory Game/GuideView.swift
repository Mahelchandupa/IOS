import SwiftUI

struct GuideView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("How to Play")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                    .foregroundColor(.blue)

                VStack(alignment: .leading, spacing: 15) {
                    guideStep(number: 1, description: "Memorize the colors and their positions within the given time.")
                    guideStep(number: 2, description: "Click on two squares to match their colors.")
                    guideStep(number: 3, description: "Match all pairs correctly to win.")
                    guideStep(number: 4, description: "The game will restart automatically after completing all matches.")
                    guideStep(number: 5, description: "If you click on two wrong squares, the game will end.")
                }

                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            .padding()
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
    }

    private func guideStep(number: Int, description: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Text("\(number).")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .frame(width: 25, alignment: .leading)
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    GuideView()
}