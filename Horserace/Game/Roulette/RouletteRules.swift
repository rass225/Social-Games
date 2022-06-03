import SwiftUI

struct RouletteRules: View {
    
    private let rules: RuleBook = RuleBook()
    
    var body: some View {
        ForEach(rules.roulette) { item in
            DefaultRuleCell(image: item.image, title: item.title, rule: item.rule)
        }
    }
}
