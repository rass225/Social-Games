import SwiftUI

struct WheelGame: View {
    @EnvironmentObject var game: Game
    @Environment(\.presentationMode) var presentationMode
    let players: [String]
    let components: [String]
    @State var currentPlayer: Int = 0
    @State var isRulesOpen: Bool = false
    @State var hasPlayersShuffled: Bool = false
    var body: some View {
        VStack(spacing: 0){
            PlayersBoard(currentPlayer: $currentPlayer, hasPlayersShuffled: $hasPlayersShuffled, players: players)
            GeometryReader { geo in
                let size = geo.size
                VStack{
                    Spacer()
                    FortuneWheel(titles: components, size: size, onSpinEnd: { i in
                        incrementPlayer()
                    })
                    Spacer()
                }
            }.padding(.horizontal)
        }
        .navigationModifier(game: .wheel)
        .gameViewModifier(game: .wheel)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                HomeButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesButton(isOpen: $isRulesOpen)
            }
            ToolbarItem(placement: .principal) {
                GameTitle()
            }
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
    }
    
    func incrementPlayer() {
        if currentPlayer == players.count - 1 {
            currentPlayer = 0
        } else {
            currentPlayer += 1
        }
    }
}
