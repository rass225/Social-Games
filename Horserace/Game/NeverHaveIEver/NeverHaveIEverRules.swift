import Foundation
import SwiftUI

struct NeverHaveIEverRules: View {

    let rules: RuleBook = RuleBook()
    
    var body: some View {
        ForEach(rules.horseRace) { item in
            Text("ass")
        }
    }
}
