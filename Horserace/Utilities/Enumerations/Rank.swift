import Foundation

enum Rank: String {
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "J"
    case queen = "Q"
    case king = "K"
    case ace = "A"
    
    var isFaceCard: Bool {
        switch self {
        case .two: return false
        case .three: return false
        case .four: return false
        case .five: return false
        case .six: return false
        case .seven: return false
        case .eight: return false
        case .nine: return false
        case .ten: return false
        case .jack: return true
        case .queen: return true
        case .king: return true
        case .ace: return true
        }
    }
    
    var number: Int {
        switch self {
        case .two: return 2
        case .three: return 3
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .seven: return 7
        case .eight: return 8
        case .nine: return 9
        case .ten: return 10
        case .jack: return 11
        case .queen: return 12
        case .king: return 13
        case .ace: return 14
        }
    }
}
