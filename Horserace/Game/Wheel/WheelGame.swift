import SwiftUI

struct WheelGame: View {
    let players: [String]
    let components: [String]
    @State var currentPlayer: Int = 0
    @State var isRulesOpen: Bool = false
    var body: some View {
        VStack(spacing: 0){
            PlayersBoard(currentPlayer: $currentPlayer, players: players)
                .padding(.bottom, 32)
            GeometryReader { geo in
                let size = geo.size
                VStack{
                    Spacer()
                    FortuneWheel(titles: components, size: size, onSpinEnd: { i in
                        incrementPlayer()
                    })
                    Spacer()
                    Spacer()
                }
                
            }
            .padding(.horizontal)
        }
        .maxWidth()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text(Games.wheel.rawValue))
        .gameViewModifier(game: .wheel)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    RulesMenuButton(isOpen: $isRulesOpen)
                    MainMenuMenuButton()
                }, label: {
                    Burger()
                })
            }
            GameTitle(game: .wheel)
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
