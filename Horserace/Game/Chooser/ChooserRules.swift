import SwiftUI

struct ChooserRules: View {
    
    private let rules: RuleBook = RuleBook()
    
    var body: some View {
        ForEach(rules.chooser) { item in
            DefaultRuleCell(image: item.image, title: item.title, rule: item.rule)
        }
    }
}
