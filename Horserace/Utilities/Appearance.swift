import SwiftUI

struct Appearance {
    func color(_ game: Games) -> Color {
        switch game {
        case .horseRace: return Colors.mainColor
        case .kingsCup: return Colors.mainColor
        case .truthDare: return Colors.mainColor
        case .neverHaveIEver: return Colors.mainColor
        case .pyramid: return Colors.mainColor
        case .spinBottle: return Colors.mainColor
        case .whosMostLikely: return Colors.mainColor
        case .higherLower: return Colors.mainColor
        case .chooser: return Colors.mainColor
        case .explain: return Colors.mainColor
        case .roulette: return Colors.mainColor
        case .wheel: return Colors.mainColor
        }
    }


    func icon(_ game: Games) -> Image {
        switch game {
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
        }
    }
    
    func title(_ game: Games) -> Text {
        switch game {
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
        }
    }
}
