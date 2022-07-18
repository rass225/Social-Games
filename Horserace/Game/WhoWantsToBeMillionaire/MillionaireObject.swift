import Foundation
import SwiftUI

struct MillionaireQuestion: Identifiable, Codable {
    
    var id = UUID()
    let question: String
    let answer1: String
    let answer2: String
    let answer3: String
    let answer4: String
    let correctAnswer: String
}

struct Lifelines {
    var fiftyfifty: Bool
    var skipQuestion: Bool
    var askCrowd: Bool
    
    mutating func reset() {
        self.fiftyfifty = false
        self.skipQuestion = false
        self.askCrowd = false
    }
}
