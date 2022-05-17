import Foundation
import SwiftUI

public enum Constant {
    
    enum KingsCupRules {
        static let ace = KingsCupRule(title: "Waterfall", rule: "Everyone drinks, staring with you. A player can end drinking when the previous player does")
        static let two = KingsCupRule(title: "You", rule: "Pick someone to take a drink")
        static let three = KingsCupRule(title: "Me", rule: "Take a drink")
        static let four = KingsCupRule(title: "Whores", rule: "Ladies drink")
        static let five = KingsCupRule(title: "Drive", rule: "XXXXXX")
        static let six = KingsCupRule(title: "Dicks", rule: "Gentlemen drink")
        static let seven = KingsCupRule(title: "Heaven", rule: "Put your fingers up in the air. last one drinks")
        static let eight = KingsCupRule(title: "Mate", rule: "Find a buddy, who drinks every time you drink throughout the game")
        static let nine = KingsCupRule(title: "Rhyme", rule: "Pick a word, others must rhyme it or drink")
        static let ten = KingsCupRule(title: "Categories", rule: "Pick a category, others need to say things in the category, or drink")
        static let jack = KingsCupRule(title: "Rule", rule: "Make a rule that lasts the entire game")
        static let queen = KingsCupRule(title: "Question Master", rule: "Ask questions. Who answers, drinks. Who responses with a questions, makes you drink. Effect lasts until a new queen is drawn.")
        static let king = KingsCupRule(title: "Pour to the Cup", rule: "The person, who picks the last king, drinks the mix. Game over!")

    }
    
    static let deck: [Deck] = [
        Deck(suit: .diamond, rank: .two, icon: Images.diamond),
        Deck(suit: .diamond, rank: .three, icon: Images.diamond),
        Deck(suit: .diamond, rank: .four, icon: Images.diamond),
        Deck(suit: .diamond, rank: .five, icon: Images.diamond),
        Deck(suit: .diamond, rank: .six, icon: Images.diamond),
        Deck(suit: .diamond, rank: .seven, icon: Images.diamond),
        Deck(suit: .diamond, rank: .eight, icon: Images.diamond),
        Deck(suit: .diamond, rank: .nine, icon: Images.diamond),
        Deck(suit: .diamond, rank: .ten, icon: Images.diamond),
        Deck(suit: .diamond, rank: .jack, icon: Images.diamond),
        Deck(suit: .diamond, rank: .queen, icon: Images.diamond),
        Deck(suit: .diamond, rank: .king, icon: Images.diamond),
        Deck(suit: .heart, rank: .two, icon: Images.heart),
        Deck(suit: .heart, rank: .three, icon: Images.heart),
        Deck(suit: .heart, rank: .four, icon: Images.heart),
        Deck(suit: .heart, rank: .five, icon: Images.heart),
        Deck(suit: .heart, rank: .six, icon: Images.heart),
        Deck(suit: .heart, rank: .seven, icon: Images.heart),
        Deck(suit: .heart, rank: .eight, icon: Images.heart),
        Deck(suit: .heart, rank: .nine, icon: Images.heart),
        Deck(suit: .heart, rank: .ten, icon: Images.heart),
        Deck(suit: .heart, rank: .jack, icon: Images.heart),
        Deck(suit: .heart, rank: .queen, icon: Images.heart),
        Deck(suit: .heart, rank: .king, icon: Images.heart),
        Deck(suit: .spades, rank: .two, icon: Images.spade),
        Deck(suit: .spades, rank: .three, icon: Images.spade),
        Deck(suit: .spades, rank: .four, icon: Images.spade),
        Deck(suit: .spades, rank: .five, icon: Images.spade),
        Deck(suit: .spades, rank: .six, icon: Images.spade),
        Deck(suit: .spades, rank: .seven, icon: Images.spade),
        Deck(suit: .spades, rank: .eight, icon: Images.spade),
        Deck(suit: .spades, rank: .nine, icon: Images.spade),
        Deck(suit: .spades, rank: .ten, icon: Images.spade),
        Deck(suit: .spades, rank: .jack, icon: Images.spade),
        Deck(suit: .spades, rank: .queen, icon: Images.spade),
        Deck(suit: .spades, rank: .king, icon: Images.spade),
        Deck(suit: .clubs, rank: .two, icon: Images.club),
        Deck(suit: .clubs, rank: .three, icon: Images.club),
        Deck(suit: .clubs, rank: .four, icon: Images.club),
        Deck(suit: .clubs, rank: .five, icon: Images.club),
        Deck(suit: .clubs, rank: .six, icon: Images.club),
        Deck(suit: .clubs, rank: .seven, icon: Images.club),
        Deck(suit: .clubs, rank: .eight, icon: Images.club),
        Deck(suit: .clubs, rank: .nine, icon: Images.club),
        Deck(suit: .clubs, rank: .ten, icon: Images.club),
        Deck(suit: .clubs, rank: .jack, icon: Images.club),
        Deck(suit: .clubs, rank: .queen, icon: Images.club),
        Deck(suit: .clubs, rank: .king, icon: Images.club),
        Deck(suit: .diamond, rank: .ace, icon: Images.diamond),
        Deck(suit: .clubs, rank: .ace, icon: Images.club),
        Deck(suit: .spades, rank: .ace, icon: Images.spade),
        Deck(suit: .heart, rank: .ace, icon: Images.heart)
    ]
    
    
}

struct Deck: Identifiable {
    var id = UUID()
    let suit: Suit
    let rank: Rank
    let icon: Image
//    let color: Color
}

struct KingsCupRule {
    var title: String
    var rule: String
}

