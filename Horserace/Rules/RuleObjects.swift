import Foundation
import SwiftUI

struct HorseRaceRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}

struct KingsCupRules: Identifiable {
    var id = UUID()
    var deck: Deck
    var title: String
    var rule: String
}

struct TruthOrDareRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}

struct NeverHaveIEverRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}

struct PyramidRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}

struct RouletteRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}

struct WheelRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}

struct ChooserRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}

struct SpinBottleRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}

struct HigherLowerRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}

struct WhosMostLikelyRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}

struct TriviaRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}

struct MillionaireRule: Identifiable {
    var id = UUID()
    let image: Image
    let title: String
    let rule: String
}
