import Foundation
import SwiftUI

struct WhosMostLikelyRules: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var game: Game
    
    private let rules: RuleBook = RuleBook()
    
    var body: some View {
        ForEach(rules.whosMostLikely) { item in
            DefaultRuleCell(image: item.image, title: item.title, rule: item.rule)
        }
    }
}
