import SwiftUI

struct NeverHaveIEverGame: View {
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: NeverEverModel
    @State var isRulesOpen: Bool = false
    @State var hasPlayersShuffled: Bool = false
    init(players: [String]) {
        self.model = NeverEverModel(players: players)
    }
    
    var body: some View {
        VStack{
            PlayersBoard(currentPlayer: $model.currentPlayer, hasPlayersShuffled: $hasPlayersShuffled, players: model.players)
            HStack(spacing: 0){
                Button(action: {
                    model.selectTier(tier: .friendly)
                }) {
                    Text("Friendly")
                        .maxWidth()
                        .foregroundColor(model.tier == .friendly ? game.game.color : .white)
                        .font(.subheadline)
                }
                Divider().background(.white)
                Button(action: {
                    model.selectTier(tier: .challenging)
                }) {
                    Text("Challenging")
                        .maxWidth()
                        .foregroundColor(model.tier == .challenging ? game.game.color : .white)
                        .font(.subheadline)
                }
                Divider().background(.white)
                Button(action: {
                    model.selectTier(tier: .naughty)
                }) {
                    Text("Naughty")
                        .maxWidth()
                        .foregroundColor(model.tier == .naughty ? game.game.color : .white)
                        .font(.subheadline)
                }
            }
            .frame(maxHeight: 36)
            .background(game.game.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.top, 8)
            GeometryReader { geo in
                let size = geo.size
                if model.status == .activity {
                    VStack(alignment: .leading, spacing: 8){
                        Text("Never Have I Ever")
                            .font(.title.weight(.semibold))
                            .foregroundColor(Colors.text)
                        if model.status == .activity {
                            Text(model.currentStatement)
                                .font(.headline.weight(.regular))
                                .foregroundColor(.gray)
                        }
                    }
                    .maxWidth(alignment: .leading)
                    .padding(.top, size.height / 4)
                } else {
                    Text(model.currentTitle)
                        .font(.title.weight(.semibold))
                        .foregroundColor(Colors.text)
                        .maxWidth()
                        .padding(.top, size.height / 4)
                }
            }
            Button(action: {
                model.mainButtonAction()
            }) {
                MainButton(label: model.mainButtonLabel())
            }
        }
        .gameViewModifier(game: .neverHaveIEver)
        .navigationModifier(game: .neverHaveIEver)
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
        .onAppear{
            model.fetchNeverHaveIEver()
        }
    }
}

