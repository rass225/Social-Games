import SwiftUI

struct WheelRules: View {
    
    private let rules: RuleBook = RuleBook()
    
    var body: some View {
        ForEach(rules.wheel) { item in
            DefaultRuleCell(image: item.image, title: item.title, rule: item.rule)
        }
    }
}
