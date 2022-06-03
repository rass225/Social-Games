import SwiftUI

struct KingsCupRulesSheet: View {
    
    let rules: RuleBook = RuleBook()
    let size: CGSize
    
    var body: some View {
        ForEach(rules.kingsCup) { item in
            HStack(alignment: .top, spacing: 16){
                Card(suit: item.deck.suit, rank: item.deck.rank, size: .small, geometry: size)
                VStack(alignment: .leading){
                    Text(item.title)
                        .font(.title3.weight(.semibold))
                    Text(item.rule)
                        .font(.subheadline.weight(.regular))
                        .maxWidth(alignment: .leading)
                        .foregroundColor(.gray)
                }
            }
            .padding(.leading, 2)
        }.padding(.top)
    }
}


