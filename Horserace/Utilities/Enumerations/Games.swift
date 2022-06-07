import Foundation
import SwiftUI

enum Games: String {
    case horseRace = "Horse Race"
    case kingsCup = "King's Cup"
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
    
    var icon : Image {
        switch self {
        case .horseRace: return Images.horse
        case .kingsCup: return Images.crown
        case .truthDare: return Images.hexagon
        case .neverHaveIEver: return Images.seal
        case .pyramid: return Images.pyramid
        case .spinBottle: return Images.bottle
        case .whosMostLikely: return Images.pentagon
        case .higherLower: return Images.higherLower
        case .chooser: return Images.chooser
        case .explain: return Images.explain
        case .wheel: return Images.wheel
        case .roulette: return Images.roulette
        case .mancala: return Images.mancala
        }
    }
    
    var title : Text {
        switch self {
        case .horseRace: return Text("Horse Race")
        case .kingsCup: return Text("King's Cup")
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
        }
    }
    
    var color : Color {
        switch self {
        case .horseRace: return Colors.Foregrounds.theme1
        case .kingsCup: return Colors.Foregrounds.theme2
        case .truthDare: return Colors.Foregrounds.theme8
        case .neverHaveIEver: return Colors.Foregrounds.theme9
        case .pyramid: return Colors.Foregrounds.theme3
        case .spinBottle: return Colors.Foregrounds.theme4
        case .whosMostLikely: return Colors.Foregrounds.theme10
        case .higherLower: return Colors.Foregrounds.theme10
        case .chooser: return Colors.Foregrounds.theme7
        case .explain: return Colors.Foregrounds.theme1
        case .roulette: return Colors.Foregrounds.theme6
        case .wheel: return Colors.Foregrounds.theme5
        case .mancala: return Colors.Foregrounds.theme11
        }
    }
    
    var background : [Color] {
        switch self {
        case .horseRace: return Colors.Backgrounds.theme1
        case .kingsCup: return Colors.Backgrounds.theme2
        case .truthDare: return Colors.Backgrounds.theme8
        case .neverHaveIEver: return Colors.Backgrounds.theme9
        case .pyramid: return Colors.Backgrounds.theme3
        case .spinBottle: return Colors.Backgrounds.theme4
        case .whosMostLikely: return Colors.Backgrounds.theme10
        case .higherLower: return Colors.Backgrounds.theme10
        case .chooser: return Colors.Backgrounds.theme7
        case .explain: return Colors.Backgrounds.theme10
        case .roulette: return Colors.Backgrounds.theme6
        case .wheel: return Colors.Backgrounds.theme5
        case .mancala: return Colors.Backgrounds.theme11
        }
    }
    
    var gradient : LinearGradient {
        LinearGradient(gradient: Gradient(colors: background), startPoint: .bottom, endPoint: .top)
    }
}
