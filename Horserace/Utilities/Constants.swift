import Foundation
import SwiftUI

public enum Constant {
    
    static let deck: [Deck] = [
        Deck(suit: .diamond, rank: .two),
        Deck(suit: .diamond, rank: .three),
        Deck(suit: .diamond, rank: .four),
        Deck(suit: .diamond, rank: .five),
        Deck(suit: .diamond, rank: .six),
        Deck(suit: .diamond, rank: .seven),
        Deck(suit: .diamond, rank: .eight),
        Deck(suit: .diamond, rank: .nine),
        Deck(suit: .diamond, rank: .ten),
        Deck(suit: .diamond, rank: .jack),
        Deck(suit: .diamond, rank: .queen),
        Deck(suit: .diamond, rank: .king),
        Deck(suit: .heart, rank: .two),
        Deck(suit: .heart, rank: .three),
        Deck(suit: .heart, rank: .four),
        Deck(suit: .heart, rank: .five),
        Deck(suit: .heart, rank: .six),
        Deck(suit: .heart, rank: .seven),
        Deck(suit: .heart, rank: .eight),
        Deck(suit: .heart, rank: .nine),
        Deck(suit: .heart, rank: .ten),
        Deck(suit: .heart, rank: .jack),
        Deck(suit: .heart, rank: .queen),
        Deck(suit: .heart, rank: .king),
        Deck(suit: .spades, rank: .two),
        Deck(suit: .spades, rank: .three),
        Deck(suit: .spades, rank: .four),
        Deck(suit: .spades, rank: .five),
        Deck(suit: .spades, rank: .six),
        Deck(suit: .spades, rank: .seven),
        Deck(suit: .spades, rank: .eight),
        Deck(suit: .spades, rank: .nine),
        Deck(suit: .spades, rank: .ten),
        Deck(suit: .spades, rank: .jack),
        Deck(suit: .spades, rank: .queen),
        Deck(suit: .spades, rank: .king),
        Deck(suit: .clubs, rank: .two),
        Deck(suit: .clubs, rank: .three),
        Deck(suit: .clubs, rank: .four),
        Deck(suit: .clubs, rank: .five),
        Deck(suit: .clubs, rank: .six),
        Deck(suit: .clubs, rank: .seven),
        Deck(suit: .clubs, rank: .eight),
        Deck(suit: .clubs, rank: .nine),
        Deck(suit: .clubs, rank: .ten),
        Deck(suit: .clubs, rank: .jack),
        Deck(suit: .clubs, rank: .queen),
        Deck(suit: .clubs, rank: .king),
        Deck(suit: .diamond, rank: .ace),
        Deck(suit: .clubs, rank: .ace),
        Deck(suit: .spades, rank: .ace),
        Deck(suit: .heart, rank: .ace)
    ]
}

struct Deck: Identifiable {
    var id = UUID()
    let suit: Suit
    let rank: Rank
}

struct KingsCupRule {
    var title: String
    var rule: String
}

