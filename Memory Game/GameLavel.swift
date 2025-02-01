enum GameLevel: Int {
    case twoByTwo = 2
    case threeByThree = 3
    case fourByFour = 4
    
    var timeLimit: Int {
        switch self {
        case .twoByTwo: return 30
        case .threeByThree: return 45
        case .fourByFour: return 60
        }
    }
    
    var memorizationTime: Int {
        switch self {
        case .twoByTwo: return 3
        case .threeByThree: return 4
        case .fourByFour: return 5
        }
    }
    
    var highScoreKey: String {
        switch self {
        case .twoByTwo: return "highScores_2x2"
        case .threeByThree: return "highScores_3x3"
        case .fourByFour: return "highScores_4x4"
        }
    }
}
