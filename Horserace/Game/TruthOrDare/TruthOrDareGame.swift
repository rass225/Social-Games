import SwiftUI

struct TruthOrDareGame: View {
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: TruthOrDareModel
    @State var isRulesOpen: Bool = false
    @State var hasPlayersShuffled: Bool = false
    init(players: [String]) {
        self.model = TruthOrDareModel(players: players)
    }
    
    var body: some View {
        VStack{
            PlayersBoard(currentPlayer: $model.currentPlayer, hasPlayersShuffled: $hasPlayersShuffled, players: model.players)
            GeometryReader { geo in
                let size = geo.size
                let desiredWidth = size.width / 1.25
                if model.status == .activity {
                    Ticket(desiredWidth: desiredWidth, title: model.title, subtitle: $model.label, footnote: model.tier.rawValue)
                        .maxWidth()
                        .maxHeight()
                } else {
                    Text(model.title)
                        .font(.title.weight(.semibold))
                        .foregroundColor(Colors.text)
                        .maxWidth()
                        .padding(.top, size.height / 4)
                }
            }
            
            switch model.status {
            case .notStarted:
                Button(action: {
                    model.status = .truthOrDare
                    model.titleHandler()
                }) {
                    MainButton(label: "Play")
                }.buttonStyle(PlainButtonStyle())
            case .truthOrDare:
                HStack(spacing: 16){
                    Button(action: {
                        model.truthHandler()
                        model.titleHandler()
                    }) {
                        MainButton(label: "Truth")
                    }
                    Button(action: {
                        model.dareHandler()
                        model.titleHandler()
                    }) {
                        MainButton(label: "Dare")
                    }
                }.buttonStyle(PlainButtonStyle())
            case .activity:
                Button(action: {
                    model.status = .truthOrDare
                    model.incrementPlayer()
                    model.titleHandler()
                }) {
                    MainButton(label: "Next Player")
                }.buttonStyle(PlainButtonStyle())
            }
        }
        .gameViewModifier(game: .truthDare)
        .navigationModifier(game: .truthDare)
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
                            model.selectTier(tier: .friendly)
                        }) {
                            Image(systemName: model.tier == .friendly ? Images.Tiers.Friendly.selected : Images.Tiers.Friendly.unselected)
                            Text("Friendly")
                        }
                        Button(action: {
                            model.selectTier(tier: .challenging)
                        }) {
                            Image(systemName: model.tier == .challenging ? Images.Tiers.Challenging.selected : Images.Tiers.Challenging.unselected)
                            Text("Challenging")
                        }
                        Button(action: {
                            model.selectTier(tier: .naughty)
                        }) {
                            Image(systemName: model.tier == .naughty ? Images.Tiers.Naughty.selected : Images.Tiers.Naughty.unselected)
                            Text("Naughty")
                        }
                    }
                }, label: {
                    GameMenuButton()
                })
//
            }
            ToolbarItem(placement: .principal) {
                GameTitle()
            }
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
        .onAppear{
            model.fetchTruth()
            model.fetchDare()
        }
    }
}
