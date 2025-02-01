import SwiftUI

struct HighScoreView: View {
    @State private var highScores: [GameLevel: [Int]] = [:]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("High Scores")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            ScrollView {
                VStack(spacing: 30) {
                    ForEach([GameLevel.twoByTwo, .threeByThree, .fourByFour], id: \.rawValue) { level in
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Level \(level.rawValue)x\(level.rawValue)")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            if let scores = highScores[level], !scores.isEmpty {
                                ForEach(scores.indices.prefix(10), id: \.self) { index in
                                    HStack {
                                        Text("\(index + 1).")
                                            .font(.title3)
                                            .fontWeight(.medium)
                                        
                                        Spacer()
                                        
                                        Text("Score: \(scores[index])")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                    }
                                    .padding()
                                    .background(Color(UIColor.systemGray5))
                                    .cornerRadius(8)
                                }
                            } else {
                                Text("No scores yet")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                    .padding(.top, 10)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .padding()
        .onAppear(loadHighScores)
    }
    
    private func loadHighScores() {
        for level in [GameLevel.twoByTwo, .threeByThree, .fourByFour] {
            let scores = UserDefaults.standard.getHighScores(forKey: level.highScoreKey)
            highScores[level] = scores
        }
    }
}