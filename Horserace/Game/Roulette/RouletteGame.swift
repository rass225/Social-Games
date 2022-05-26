import SwiftUI

struct RouletteGame: View {
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: RouletteModel
    @State var isRulesOpen: Bool = false
    
    init(players: [String]) {
        model = RouletteModel(players: players)
    }

    var body: some View {
        VStack {
            PlayersBoard(currentPlayer: $model.currentPlayer, hasPlayersShuffled: $model.hasPlayersShuffled, players: model.players)
                
            rouletteTable
               
            betBoard
            
            switch model.status {
            case .notStarted:
                Button(action: {
                    model.mainAction()
                }) {
                    MainButton(label: "Play")
                }
            case .betting:
                Button(action: {
                    model.mainAction()
                }) {
                    MainButton(label: "Spin")
                }
                .opacity(model.placedBet == .none ? 0.5 : 1)
                .disabled(model.placedBet == .none ? true : false)
                .animation(.linear(duration: 0.5), value: model.placedBet)
            case .roulette:
                Button(action: {
                    model.mainAction()
                }) {
                    MainButton(label: "Next Player")
                }
                .disabled(model.isAnimating == true)
                .opacity(model.isAnimating ? 0.5 : 1)
            }
        }
        .navigationModifier(game: .roulette)
        .gameViewModifier(game: game.game)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                HomeButton()
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
}

