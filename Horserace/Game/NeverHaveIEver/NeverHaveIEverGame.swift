import SwiftUI

struct NeverHaveIEverGame: View {
    
    @ObservedObject var model: NeverEverModel
    @State var isRulesOpen: Bool = false
    @State var hasPlayersShuffled: Bool = false
    init(players: [String]) {
        self.model = NeverEverModel(players: players)
    }
    
    var body: some View {
        VStack(spacing: 32){
            PlayersBoard(currentPlayer: $model.currentPlayer, hasPlayersShuffled: $hasPlayersShuffled, players: model.players)
            TitleLabel(label: model.currentTitle)
            Text(model.currentStatement)
                .font(.title2.weight(.regular))
            Spacer()
            Button(action: {
                model.mainButtonAction()
            }) {
                MainButton(label: model.mainButtonLabel())
            }
        }
        .gameViewModifier(game: .neverHaveIEver)
        .navigationModifier(game: .neverHaveIEver)
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    RulesMenuButton(isOpen: $isRulesOpen)
                    MainMenuMenuButton()
                }, label: {
                    Text("Was Burger")
                })
            }
        }
    }
}

