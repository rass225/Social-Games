import SwiftUI

struct DefaultRuleCell: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var game: Game
    
    let image: Image
    let title: String
    let rule: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16){
            image
                .font(.title2.weight(.regular))
                .foregroundColor(colorScheme == .dark ? game.game.color : .init(red: 0.2, green: 0.2, blue: 0.2))
            VStack(alignment: .leading){
                Text(title)
                    .font(.title3.weight(.semibold))
                Text(rule)
                    .font(.subheadline.weight(.regular))
                    .foregroundColor(.gray)
            }
        }.maxWidth(alignment: .leading)
    }
}
