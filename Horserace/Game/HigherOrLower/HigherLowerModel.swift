import Foundation
import SwiftUI

class HigherLowerModel: ObservableObject {
    
    let players: [String]
    @Published var currentPlayer = 0
    @Published var deck = Constant.deck.shuffled()
    @Published var testRotation = CardRotation(front: 0, back: 90)
    @Published var hasPlayersShuffled: Bool = false
    
    init(players: [String]) {
        self.players = players
    }
}
