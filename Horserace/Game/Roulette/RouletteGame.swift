import SwiftUI

struct RouletteGame: View {
    
    @EnvironmentObject var game: Game
    @Environment(\.colorScheme) var scheme
    @ObservedObject var model: RouletteModel
    @State var isRulesOpen: Bool = false
    
    init(players: [String]) {
        model = RouletteModel(players: players)
    }

    var body: some View {
        VStack {
            PlayersBoard(currentPlayer: $model.currentPlayer, hasPlayersShuffled: $model.hasPlayersShuffled, players: $model.players)
                
            rouletteTable
               
            betBoard
            
            Button(model.mainButtonLabel ,action: model.mainAction)
                .buttonStyle(MainButtonStyle())
                .modifier(MainButtonModifier(model: model))
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
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
    }
    
    struct MainButtonModifier: ViewModifier {
        
        @ObservedObject var model: RouletteModel
        
        public func body(content: Content) -> some View {
            switch model.status {
            case .notStarted:
                content
            case .betting:
                content
                    .opacity(model.placedBet == .none ? 0.4 : 1)
                    .disabled(model.placedBet == .none ? true : false)
                    .animation(.linear(duration: 0.4), value: model.placedBet)
            case .roulette:
                content
                    .disabled(model.isAnimating == true)
                    .opacity(model.isAnimating ? 0.4 : 1)
            }
        }
    }
}

