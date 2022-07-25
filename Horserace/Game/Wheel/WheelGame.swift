import SwiftUI

struct WheelGame: View {
    @EnvironmentObject var game: Game
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @State var players: [String]
    let components: [String]
    @State var currentPlayer: Int = 0
    @State var isRulesOpen: Bool = false
    @State var hasPlayersShuffled: Bool = false
    
    var body: some View {
        VStack(spacing: 0){
            PlayersBoard(currentPlayer: $currentPlayer, hasPlayersShuffled: $hasPlayersShuffled, players: $players)
            GeometryReader { geo in
                let size = geo.size
                VStack{
                    Spacer()
                    FortuneWheel(titles: components, size: size, onSpinEnd: { i in
                        incrementPlayer()
                    })
                    Spacer()
                }
            }// .padding(.horizontal, 8)
        }
        .navigationModifier(game: .wheel)
        .gameViewModifier(game: .wheel)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                HomeButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    Section{
                        Button(action: {
                            isRulesOpen.toggle()
                        }) {
                            Text("Rules")
                            Images.rulesFill
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, game.game.gradient)
                        }
                    }
                    Section{
                        Button(action: {
                            dismiss()
                        }) {
                            Images.edit
                            Text("Edit Components")
                        }
                    }
                }, label: {
                    GameMenuButton()
                })
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
