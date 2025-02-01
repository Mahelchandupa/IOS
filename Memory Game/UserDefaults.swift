import Foundation

extension UserDefaults {
    func getHighScores(forKey key: String) -> [Int] {
        return array(forKey: key) as? [Int] ?? []
    }

    func setHighScores(_ scores: [Int], forKey key: String) {
        set(scores, forKey: key)
    }
}
