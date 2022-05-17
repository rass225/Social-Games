import SwiftUI

struct HorseRaceSuits: View {
    
    @EnvironmentObject var game: Game
    let players: [String]
    
    let columns = [
        GridItem(.flexible(maximum: .infinity), spacing: 16),
        GridItem(.flexible(maximum: .infinity), spacing: 16)
    ]
   
    @State var playerSuits: [HorseRacePlayers] = []
    @State var toGame: Bool = false
    
    var body: some View {
        VStack{
            NavigationLink(destination: HorceRaceGame(players: playerSuits).environmentObject(game), isActive: $toGame) {
                EmptyView()
            }
            LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                ForEach(playerSuits.indices, id: \.self) { index in
                    VStack(spacing: 0){
                        PlayerName(label: playerSuits[index].name)
                        Divider()
                            .background(.ultraThickMaterial)
                        HStack{
                            Button(action: {
                                playerSuits[index].suit = .heart
                            }) {
                                Images.heart.foregroundColor(.red.opacity(playerSuits[index].suit == .heart ? 1 : 0.5))
                            }
                            Button(action: {
                                playerSuits[index].suit = .diamond
                            }) {
                                Images.diamond.foregroundColor(.red.opacity(playerSuits[index].suit == .diamond ? 1 : 0.5))
                            }
                            Button(action: {
                                playerSuits[index].suit = .clubs
                            }) {
                                Images.club.foregroundColor(.black.opacity(playerSuits[index].suit == .clubs ? 1 : 0.5))
                            }
                            Button(action: {
                                playerSuits[index].suit = .spades
                            }) {
                                Images.spade.foregroundColor(.black.opacity(playerSuits[index].suit == .spades ? 1 : 0.5))
                            }
                        }
                        .padding(.vertical, 12)
                        .font(.title)
                        
                    }
                    .background(Material.thinMaterial)
                    .cornerRadius(16)
                }
            }
            Spacer()
            Button(action: {
                for item in playerSuits {
                    print("\(item.name) picked \(item.suit ?? .diamond)")
                }
                toGame.toggle()
            }) {
                MainButton(label: "Play")
            }
            .opacity(allSet() ? 1 : 0.7)
            .disabled(allSet() ? false : true)
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .background(
            DefaultBackground()
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            GameTitle(game: .horseRace)
        }
        .onAppear{
            for item in players {
                playerSuits.append(HorseRacePlayers(name: item, suit: nil))
            }
        }
    }
    
    private struct PlayerName: View {
        let label: String
        var body: some View {
            Text(label)
                .padding(.vertical, 8)
                .font(.headline.weight(.regular))
                .foregroundColor(Colors.text)
        }
    }
    
    private func allSet() -> Bool {
        if playerSuits.contains(where: { $0.suit == nil }) {
            return false
        } else {
            return true
        }
    }
}

struct HorseRacePlayers: Hashable {
    var id = UUID()
    var name: String
    var suit: Suit?
}
