import SwiftUI

struct RouletteRules: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var game: Game
    private let rules: RuleBook = RuleBook()
    
    var body: some View {
        VStack(spacing: 32){
            ForEach(rules.roulette) { item in
                HStack(alignment: .top, spacing: 16){
                    item.image
                        .font(.title2.weight(.regular))
                        .foregroundColor(colorScheme == .dark ? game.color : .init(red: 0.2, green: 0.2, blue: 0.2))
                    VStack(alignment: .leading){
                        Text(item.title)
                            .font(.title3.weight(.semibold))
                        Text(item.rule)
                            .font(.subheadline.weight(.regular))
                            .foregroundColor(.gray)
                    }
                }.maxWidth(alignment: .leading)
            }
        }.padding(.horizontal)
    }
}
