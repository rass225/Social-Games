import Foundation
import SwiftUI

struct HigherLowerRules: View {
    
    private let rules: RuleBook = RuleBook()
    
    var body: some View {
        ForEach(rules.higherLower) { item in
            DefaultRuleCell(image: item.image, title: item.title, rule: item.rule)
        }
    }
}
