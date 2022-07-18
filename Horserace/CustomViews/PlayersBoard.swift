import SwiftUI

struct PlayersBoard: View {
    
    @Binding var currentPlayer: Int
    @Binding var hasPlayersShuffled: Bool
    @EnvironmentObject var game: Game
    @Environment(\.colorScheme) var scheme
    
    @State var players: [String]
    
    private let selectedFont: Font = .headline.weight(.medium)
    private let unselectedFont: Font = .subheadline.weight(.light)
    
    let columns = [
        GridItem(.flexible(maximum: .infinity), spacing: 0, alignment: .center),
        GridItem(.flexible(maximum: .infinity), spacing: 0, alignment: .center),
        GridItem(.flexible(maximum: .infinity), spacing: 0, alignment: .center)
    ]
    
    var body: some View {
        ZStack(alignment: .top){
            VStack(alignment: .center, spacing: 0){
                LazyVGrid(columns: columns, alignment: .trailing, spacing: 0) {
                    ForEach(players.indices, id: \.self) { index in
                        Text(players[index])
                            .font(currentPlayer == index ? selectedFont : unselectedFont)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .cornerRadius(8)
                            .modifier(ForegroundModifier(currentPlayer: $currentPlayer, index: index))
                            .padding(.vertical, 4)
                    }
                }
            }
            .padding(8)
            .background(.ultraThickMaterial)
            .mask(RoundCorners())
            .shadow(color: Colors.darkShadow2, radius: 5, x: 0, y: 8)
            
            if !hasPlayersShuffled && players.count > 1 {
                Button(action: {
                    players.shuffle()
                    hasPlayersShuffled.toggle()
                }) {
                    shuffle
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    var shuffle: some View {
        Images.shuffle
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, game.game.gradient)
            .font(.title)
            .offset(y: -16)
    }
    
    struct ForegroundModifier: ViewModifier {
        @EnvironmentObject var game: Game
        @Environment(\.colorScheme) var scheme
        @Binding var currentPlayer: Int
        let index: Int
        
        func body(content: Content) -> some View {
            if game.game == .roulette {
                content
                    .foregroundColor(currentPlayer == index ? (scheme == .light ? game.game.background[0] : game.game.color) : Colors.text)
            } else if game.game == .pyramid {
                content
                    .foregroundColor(currentPlayer == index ? game.game.background[0] : Colors.text)
            } else if game.game == .wheel {
                content
                    .foregroundColor(currentPlayer == index ? (scheme == .light ? game.game.background[0] : game.game.color) : Colors.text )
            } else if game.game == .higherLower {
                content
                    .foregroundColor(currentPlayer == index ? (scheme == .light ? game.game.background[0] : game.game.background[1]) : Colors.text)
            } else {
                content
                    .foregroundColor(currentPlayer == index ? game.game.color : Colors.text)
            }
        }
    }
}

