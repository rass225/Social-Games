import SwiftUI

struct PyramidRules: View {
    
    private let rules = RuleBook()
    
    var body: some View {
        ForEach(rules.pyramid) { item in
            DefaultRuleCell(image: item.image, title: item.title, rule: item.rule)
        }
    }
}
