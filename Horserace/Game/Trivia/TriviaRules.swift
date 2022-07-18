import Foundation
import SwiftUI

struct TriviaRules: View {
    
    @EnvironmentObject var game: Game
    
    private let rules: RuleBook = RuleBook()
    
    var body: some View {
        ForEach(rules.trivia) { item in
            DefaultRuleCell(image: item.image, title: item.title, rule: item.rule)
        }
    }
}
