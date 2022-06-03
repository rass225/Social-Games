import SwiftUI

struct HorseRaceRules: View {
    
    private let rules = RuleBook()
    
    var body: some View {
        ForEach(rules.horseRace) { item in
            DefaultRuleCell(image: item.image, title: item.title, rule: item.rule)
        }
    }
}
