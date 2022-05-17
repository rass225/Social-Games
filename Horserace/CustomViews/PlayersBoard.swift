import SwiftUI

struct PlayersBoard: View {
    
    @Binding var currentPlayer: Int
    @EnvironmentObject var game: Game
    
    let players: [String]
    
    let columns = [
        GridItem(.flexible(maximum: .infinity), spacing: 0, alignment: .center),
        GridItem(.flexible(maximum: .infinity), spacing: 0, alignment: .center),
        GridItem(.flexible(maximum: .infinity), spacing: 0, alignment: .center)
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            LazyVGrid(columns: columns, alignment: .trailing, spacing: 0) {
                ForEach(players.indices, id: \.self) { index in
                    Text(players[index])
                        .font(currentPlayer == index ? .headline.weight(.medium) : .subheadline.weight(.light))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .cornerRadius(8)
                        .foregroundColor(currentPlayer == index ? Colors.mainColor : Colors.text)
                        .padding(.vertical, 4)
                }
            }
        }
        .padding(8)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.vertical, 8)
    }

}

