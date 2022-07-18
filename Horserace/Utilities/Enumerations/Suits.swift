import Foundation
import SwiftUI

enum Suit: String {
    case heart
    case diamond
    case spades
    case clubs
    
    var color: Color {
        switch self {
        case .heart: return .red
        case .diamond: return .red
        case .spades: return .black
        case .clubs: return .black
        }
    }
    
    var image: Image {
        switch self {
        case .heart: return Images.heart
        case .diamond: return Images.diamond
        case .spades: return Images.spade
        case .clubs: return Images.club
        }
    }
}
