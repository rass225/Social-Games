import Foundation
import SwiftUI

class HorseRaceModel: ObservableObject {
    
    let players: [HorseRacePlayers]
    
    @Published var deck = Constant.deck.shuffled()
    @Published var deckIndex: Int = 5
    
    @Published var isThereAWinner: Bool = false
    @Published var state: GameState = .notStarted
    @Published var mainLabel = "Play"
    @Published var winnerSuit: Suit?
    @Published var diamondOffset: CGFloat = 0
    @Published var heartOffset: CGFloat = 0
    @Published var spadeOffset: CGFloat = 0
    @Published var clubOffset: CGFloat = 0
    
    @Published var firstBase = CardRotation(front: -90, back: 0)
    @Published var secondBase = CardRotation(front: -90, back: 0)
    @Published var thirdBase = CardRotation(front: -90, back: 0)
    @Published var fourthBase = CardRotation(front: -90, back: 0)
    @Published var fifthBase = CardRotation(front: -90, back: 0)
    private var hasGameStarted: Bool = false
    private var penaltyBase: Base = .zero
    
    init(players: [HorseRacePlayers]) {
        self.players = players
    }
    
    enum GameState {
        case notStarted
        case game
        case winner
    }
    
    enum Base {
        case zero
        case first
        case second
        case third
        case fourth
        case fifth
    }
    
    private func flipPenaltyCard() {
        withAnimation(Animation.easeOut(duration: 0.5)){
            switch penaltyBase {
            case .zero: break
            case .first: firstBase.back = 90
            case .second: secondBase.back = 90
            case .third: thirdBase.back = 90
            case .fourth: fourthBase.back = 90
            case .fifth: fifthBase.back = 90
            }
        }
        withAnimation(Animation.easeOut(duration: 0.5).delay(0.5)){
            switch penaltyBase {
            case .zero: break
            case .first: firstBase.front = 0
            case .second: secondBase.front = 0
            case .third: thirdBase.front = 0
            case .fourth: fourthBase.front = 0
            case .fifth: fifthBase.front = 0
            }
        }
    }
    
    private func moveDown(suit: Suit) {
        withAnimation(Animation.easeOut(duration: 1).delay(1)) {
            switch suit {
            case .heart: heartOffset -= 15
            case .diamond: diamondOffset -= 15
            case .spades: spadeOffset -= 15
            case .clubs: clubOffset -= 15
            }
        }
    }
    
    private func moveUp(suit: Suit) {
        withAnimation(Animation.easeOut(duration: 1)) {
            switch suit {
            case .heart: heartOffset += 15
            case .diamond: diamondOffset += 15
            case .spades: spadeOffset += 15
            case .clubs: clubOffset += 15
            }
        }
    }
    
    func gameLogic() {
        
        if hasGameStarted == false {
            state = .game
            hasGameStarted.toggle()
        }
        
        deckIndex += 1
        moveUp(suit: deck[deckIndex].suit)
        
        if heartOffset > 85 || diamondOffset > 85 || spadeOffset > 85 || clubOffset > 85 {
            
            if heartOffset > 85 {
                winnerSuit = .heart
            } else if diamondOffset > 85 {
                winnerSuit = .diamond
            } else if spadeOffset > 85 {
                winnerSuit = .spades
            } else if clubOffset > 85 {
                winnerSuit = .clubs
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("Game Over")
                self.isThereAWinner.toggle()
            }
        }
        
        if heartOffset >= 15 && diamondOffset >= 15 && spadeOffset >= 15 && clubOffset >= 15 {
            if penaltyBase == .zero {
                penaltyBase = .first
                flipPenaltyCard()
                moveDown(suit: deck[0].suit)
            }
        }
        
        if heartOffset >= 30 && diamondOffset >= 30 && spadeOffset >= 30 && clubOffset >= 30 {
            if penaltyBase == .first {
                penaltyBase = .second
                flipPenaltyCard()
                moveDown(suit: deck[1].suit)
            }
        }
        
        if heartOffset >= 45 && diamondOffset >= 45 && spadeOffset >= 45 && clubOffset >= 45 {
            if penaltyBase == .second {
                penaltyBase = .third
                flipPenaltyCard()
                moveDown(suit: deck[2].suit)
            }
        }
        
        if heartOffset >= 60 && diamondOffset >= 60 && spadeOffset >= 60 && clubOffset >= 60 {
            if penaltyBase == .third {
                penaltyBase = .fourth
                flipPenaltyCard()
                moveDown(suit: deck[3].suit)
            }
        }
        
        if heartOffset >= 75 && diamondOffset >= 75 && spadeOffset >= 75 && clubOffset >= 75 {
            if penaltyBase == .fourth {
                penaltyBase = .fifth
                flipPenaltyCard()
                moveDown(suit: deck[4].suit)
            }
        }
    }
    
    func restart() {
        isThereAWinner = false
        state = .notStarted
        winnerSuit = nil
        hasGameStarted = false
        penaltyBase = .zero
        
        withAnimation(Animation.easeInOut(duration: 1)){
            heartOffset = 0
            diamondOffset = 0
            spadeOffset = 0
            clubOffset = 0
        }
        
        withAnimation(Animation.easeOut(duration: 0.7)){
            firstBase.front = -90
            secondBase.front = -90
            thirdBase.front = -90
            fourthBase.front = -90
            fifthBase.front = -90
            
        }
        withAnimation(Animation.easeOut(duration: 0.7).delay(0.7)){
            firstBase.back = 0
            secondBase.back = 0
            thirdBase.back = 0
            fourthBase.back = 0
            fifthBase.back = 0
            
            deck = deck.shuffled()
            deckIndex = 5
        }
        
    }
    
    func isThereWinner() -> Bool {
        if players.contains(where: { $0.suit == winnerSuit }) {
            return true
        } else {
            return false
        }
    }
}
