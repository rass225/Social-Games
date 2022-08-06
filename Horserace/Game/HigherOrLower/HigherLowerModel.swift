import Foundation
import SwiftUI

class HigherLowerModel: ObservableObject {
    
    enum Choice {
        case higher
        case lower
    }
    
    private var deck = Constant.deck.shuffled()
    private var nextCardToAddIndex = 0
    private var choiceMade: Choice = .higher
    
    @Published var isRulesOpen: Bool = false
    @Published var players: [String]
    @Published var currentPlayer = 0
    @Published var hasPlayersShuffled: Bool = false
    @Published var leftCardRotation = CardRotation(front: 0, back: 90)
    @Published var rightCardRotation = CardRotation(front: 90, back: 0)
    @Published var rightSecondCardRotation = CardRotation(front: 90, back: 0)
    @Published var offsetX: CGFloat = 0
    @Published var dealtCards: [Deck] = []
    @Published var undealtCards: [Deck] = []
    @Published var isAnimating: Bool = false
    @Published var mainLabel: String = ""
    @Published var currentStreak: Int = 0
    @AppStorage("HigherLowerRecord") var record = 0
    @Published var currentRecord: Int = 0
    
    init(players: [String]) {
        self.players = players
    }
    
    func pickHigher(size: CGSize) {
        choiceMade = .higher
        mainAction(size: size)
    }
    
    func pickLower(size: CGSize) {
        choiceMade = .lower
        mainAction(size: size)
    }
    
    func mainAction(size: CGSize) {
        mainLabel = ""
        isAnimating.toggle()
        currentStreak += 1
        withAnimation(Animation.easeIn(duration: 0.6).delay(1.7)) {
            offsetX = (size.height / 4.5 * -1) - 20
        }
        withAnimation(Animation.easeOut(duration: 0.5)) {
            rightCardRotation.back = -90
           
        }
        withAnimation(Animation.easeOut(duration: 0.5).delay(0.5)) {
            rightCardRotation.front = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.determineOutcome()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
            self.transferToDealtDeck()
            self.addCardToUndealtDeck()
            self.incrementPlayer()
            for item in self.dealtCards {
                print("\(item.rank) of \(item.suit)")
            }
            self.isAnimating.toggle()
        }
        
        if nextCardToAddIndex == deck.count - 1 {
            deck.shuffle()
            nextCardToAddIndex = 0
        }
    }
    
    func determineOutcome() {
        let baseCard = dealtCards[dealtCards.count - 1].rank.number
        let compareCard = undealtCards[undealtCards.count - 1].rank.number
        switch choiceMade {
        case .higher:
            if compareCard > baseCard {
                
                print("Winner")
            } else {
                let penalty = currentStreak
                let currentPlayer = players[currentPlayer]
                mainLabel = "\(currentPlayer) lost on streak \(penalty)"
                if currentStreak > record {
                    record = currentStreak
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.mainLabel = "New record!!"
                    }
                }
                if currentStreak > currentRecord {
                    currentRecord = currentStreak
                }
                currentStreak = 0
                print("loser")
            }
        case .lower:
            if compareCard < baseCard {
                print("Winner")
            } else {
                let penalty = currentStreak
                let currentPlayer = players[currentPlayer]
                mainLabel = "\(currentPlayer) lost on streak \(penalty)"
                if currentStreak > record {
                    record = currentStreak
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.mainLabel = "New record!!"
                    }
                }
                if currentStreak > currentRecord {
                    currentRecord = currentStreak
                }
                currentStreak = 0
                print("loser")
            }
        }
    }
    
    func initialize() {
        dealtCards.append(deck[0])
        undealtCards.append(deck[1])
        undealtCards.append(deck[2])
        nextCardToAddIndex = 3
    }
    
    func restart() {
        withAnimation(Animation.easeInOut(duration: 0.4)) {
            rightCardRotation.front = 90
        }
        withAnimation(Animation.easeInOut(duration: 0.4).delay(0.4)) {
            rightCardRotation.back = 0
        }
        withAnimation(Animation.easeIn(duration: 1.2)) {
            offsetX = 0
        }
        currentStreak = 0
        deck.shuffle()
    }
    
    func transferToDealtDeck() {
        dealtCards.append(undealtCards[undealtCards.count - 1])
        dealtCards.removeFirst()
        undealtCards.removeFirst()
        hardResetRotation()
    }
    
    func hardResetRotation() {
        rightCardRotation.front = 90
        rightCardRotation.back = 0
        offsetX = 0
    }
    
    func addCardToUndealtDeck() {
        undealtCards.append(deck[nextCardToAddIndex])
        nextCardToAddIndex += 1
    }
    
    func incrementPlayer() {
        if currentPlayer == 10 {
            currentPlayer = 0
            return
        }
        if currentPlayer == players.count - 1 {
            currentPlayer = 0
        } else {
            currentPlayer += 1
        }
    }
    
    func showRules() {
        isRulesOpen.toggle()
    }
}
