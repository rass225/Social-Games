import Foundation
import SwiftUI

enum Games: String {
    case horseRace = "Horse Race"
    case truthDare = "Truth or Dare"
    case neverHaveIEver = "Never Have I Ever"
    case pyramid = "Pyramid"
    case spinBottle = "Spin the Bottle"
    case whosMostLikely = "Who's Most Likely"
    case higherLower = "Higher or Lower"
    case chooser = "Chooser"
    case explain = "Explain"
    case roulette = "Roulette"
    case wheel = "Wheel"
    case mancala = "Mancala"
    case trivia = "Trivia"
    case millionaire = "Who wants to be a millionaire"
    
    var icon : Image {
        switch self {
        case .horseRace: return Images.horse2
        case .truthDare: return Images.hexagon
        case .neverHaveIEver: return Images.seal
        case .pyramid: return Images.pyramid2
        case .spinBottle: return Images.bottle
        case .whosMostLikely: return Images.pentagon
        case .higherLower: return Images.higherLower
        case .chooser: return Images.chooser
        case .explain: return Images.explain
        case .wheel: return Images.wheel2
        case .roulette: return Images.roulette
        case .mancala: return Images.mancala
        case .trivia: return Images.shield
        case .millionaire: return Images.millionaire
        }
    }
    
    var image: Image {
        switch self {
        case .horseRace: return Images.horse
        case .truthDare: return Images.hexagon
        case .neverHaveIEver: return Images.seal
        case .pyramid: return Images.pyramid2
        case .spinBottle: return Images.bottle
        case .whosMostLikely: return Images.pentagon
        case .higherLower: return Images.higherLower
        case .chooser: return Images.chooser
        case .explain: return Images.explain
        case .wheel: return Images.wheel2
        case .roulette: return Images.roulette
        case .mancala: return Images.mancala
        case .trivia: return Images.shield
        case .millionaire: return Images.shield
        }
    }
    
    var title : Text {
        switch self {
        case .horseRace: return Text("Horse Race")
        case .truthDare: return Text("Truth or Dare")
        case .neverHaveIEver: return Text("Never Have I Ever")
        case .pyramid: return Text("Pyramid")
        case .spinBottle: return Text("Spin the Bottle")
        case .whosMostLikely: return Text("Who's Most Likely")
        case .higherLower: return Text("Higher or Lower")
        case .chooser: return Text("Chooser")
        case .explain: return Text("Explain")
        case .roulette: return Text("Roulette")
        case .wheel: return Text("Wheel")
        case .mancala: return Text("Mancala")
        case .trivia: return Text("Trivia")
        case .millionaire: return Text("Who Wants to be a Millionaire")
        }
    }
    
    var color : Color {
        switch self {
        case .horseRace: return Colors.Foregrounds.theme1
        case .truthDare: return Colors.Foregrounds.theme8
        case .neverHaveIEver: return Colors.Foregrounds.theme9
        case .pyramid: return Colors.Foregrounds.theme3
        case .spinBottle: return Colors.Foregrounds.theme4
        case .whosMostLikely: return Colors.Foregrounds.theme12
        case .higherLower: return Colors.Foregrounds.theme10
        case .chooser: return Colors.Foregrounds.theme7
        case .explain: return Colors.Foregrounds.theme1
        case .roulette: return Colors.Foregrounds.theme6
        case .wheel: return Colors.Foregrounds.theme5
        case .mancala: return Colors.Foregrounds.theme11
        case .trivia: return Colors.Foregrounds.theme14
        case .millionaire: return Colors.Foregrounds.theme13
        }
    }
    
    var background : [Color] {
        switch self {
        case .horseRace: return Colors.Backgrounds.theme1
        case .truthDare: return Colors.Backgrounds.theme8
        case .neverHaveIEver: return Colors.Backgrounds.theme9
        case .pyramid: return Colors.Backgrounds.theme3
        case .spinBottle: return Colors.Backgrounds.theme4
        case .whosMostLikely: return Colors.Backgrounds.theme12
        case .higherLower: return Colors.Backgrounds.theme10
        case .chooser: return Colors.Backgrounds.theme7
        case .explain: return Colors.Backgrounds.theme10
        case .roulette: return Colors.Backgrounds.theme6
        case .wheel: return Colors.Backgrounds.theme5
        case .mancala: return Colors.Backgrounds.theme11
        case .trivia: return Colors.Backgrounds.theme14
        case .millionaire: return Colors.Backgrounds.theme13
        }
    }
    
    var gradient : LinearGradient {
        LinearGradient(gradient: Gradient(colors: background), startPoint: .bottom, endPoint: .top)
    }
    
    var maxPlayers: PlayerCount {
        switch self {
        case .horseRace: return .six
        case .truthDare: return .six
        case .neverHaveIEver: return .infintiy
        case .pyramid: return .six
        case .spinBottle: return .infintiy
        case .whosMostLikely: return .infintiy
        case .higherLower: return .six
        case .chooser: return .five
        case .explain: return .infintiy
        case .roulette: return .six
        case .wheel: return .six
        case .mancala: return .two
        case .trivia: return .infintiy
        case .millionaire: return .infintiy
        }
    }
    
    enum PlayerCount {
        case one
        case two
        case three
        case four
        case five
        case six
        case infintiy
        
        var image: Image {
            switch self {
            case .one: return Image(systemName: "1.circle.fill")
            case .two: return Image(systemName: "2.circle.fill")
            case .three: return Image(systemName: "3.circle.fill")
            case .four: return Image(systemName: "4.circle.fill")
            case .five: return Image(systemName: "5.circle.fill")
            case .six: return Image(systemName: "6.circle.fill")
            case .infintiy: return Image(systemName: "infinity.circle.fill")
            }
        }
    }
}


