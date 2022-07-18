import Foundation
import SwiftUI

enum Images {
    static let heart = Image(systemName: "suit.heart.fill")
    static let diamond = Image(systemName: "suit.diamond.fill")
    static let club = Image(systemName: "suit.club.fill")
    static let spade = Image(systemName: "suit.spade.fill")
    static let restart = Image(systemName: "arrow.clockwise")
    static let restartFill = Image(systemName: "arrow.clockwise.circle.fill")
    static let mainMenu = Image(systemName: "house.circle.fill")
    static let burger = Image(systemName: "line.3.horizontal")
    static let burgerFill = Image(systemName: "line.3.horizontal.circle.fill")
    static let rules = Image(systemName: "doc.text")
    static let rulesCircleFill = Image(systemName: "doc.circle.fill")
    static let rulesFill = Image(systemName: "doc.text.fill")
    static let crown = Image(systemName: "crown.fill")
    static let hexagon = Image(systemName: "hexagon.fill")
    static let pentagon = Image(systemName: "pentagon.fill")
    static let octagon = Image(systemName: "octagon.fill")
    static let seal = Image(systemName: "seal.fill")
    static let pyramid = Image(systemName: "pyramid.fill")
    static let pyramidBig = Image("Pyramid")
    static let explain = Image(systemName: "person.wave.2")
    static let higherLower = Image(systemName: "arrow.up.arrow.down.circle.fill")
    static let chooser = Image(systemName: "dot.circle.and.hand.point.up.left.fill")
    static let bottle = Image("Bottle")
    static let horse = Image("Horses")
    static let horseBig = Image("HorseRace")
    static let roulette = Image("Roulette")
    static let wheel = Image(systemName: "gearshape.fill")
    static let edit = Image(systemName: "pencil.circle.fill")
    static let shuffle = Image(systemName: "shuffle.circle.fill")
    static let back = Image(systemName: "chevron.left.circle.fill")
    static let add = Image(systemName: "plus.circle.fill")
    static let remove = Image(systemName: "minus.circle.fill")
    static let questionMark = Image(systemName: "questionmark")
    static let diamondFill = Image(systemName: "diamond.fill")
    static let landingIndicator = Image(systemName: "arrowtriangle.down.fill")
    static let rouletteTable = Image("RouletteTable")
    static let mancala = Image("mancala")
    static let shield = Image(systemName: "shield.fill")
    
    enum Tiers {
        enum Friendly {
            static let selected = "1.circle.fill"
            static let unselected = "1.circle"
        }
        enum Challenging {
            static let selected = "2.circle.fill"
            static let unselected = "2.circle"
        }
        enum Naughty {
            static let selected = "3.circle.fill"
            static let unselected = "3.circle"
        }
    }
    
    enum Nr {
        static let one = Image(systemName: "1.circle")
        static let two = Image(systemName: "2.circle")
        static let three = Image(systemName: "3.circle")
        static let four = Image(systemName: "4.circle")
        static let five = Image(systemName: "5.circle")
        static let six = Image(systemName: "6.circle")
        static let seven = Image(systemName: "7.circle")
        static let eight = Image(systemName: "8.circle")
        static let nine = Image(systemName: "9.circle")
    }
}
