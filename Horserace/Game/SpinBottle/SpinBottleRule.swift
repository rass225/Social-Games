import SwiftUI

struct SpinBottleRules: View {
    
    private let rules: RuleBook = RuleBook()
    
    var body: some View {
        ForEach(rules.spinBottle) { item in
            DefaultRuleCell(image: item.image, title: item.title, rule: item.rule)
        }
    }
}
