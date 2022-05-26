import Foundation
import SwiftUI

struct FullCard: View {
    
    @Binding var card: Deck
    @Binding var rotation: CardRotation
    let size: Size
    let geo: CGSize
    
    var body: some View {
        ZStack{
            Card(suit: card.suit, rank: card.rank, size: size, geometry: geo)
                .rotation3DEffect(Angle(degrees: rotation.front), axis: (x: 0, y: 1, z: 0))
            CardBack(size: size, geometry: geo)
                .rotation3DEffect(Angle(degrees: rotation.back), axis: (x: 0, y: 1, z: 0))
        }
    }
}

struct CardRotation {
    var front: Double
    var back: Double
}
