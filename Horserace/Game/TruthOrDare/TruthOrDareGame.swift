import SwiftUI

struct TruthOrDareGame: View {
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: TruthOrDareModel
    
    @State var hasPlayersShuffled: Bool = false
    init(players: [String]) {
        self.model = TruthOrDareModel(players: players)
    }
    
    var body: some View {
        VStack{
            PlayersBoard(currentPlayer: $model.currentPlayer, hasPlayersShuffled: $hasPlayersShuffled, players: $model.players)
            GeometryReader { geo in
                let size = geo.size
                let desiredWidth = size.width / 1.20
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
                Button("Play", action: {
                    model.status = .truthOrDare
                    model.titleHandler()
                }).buttonStyle(MainButtonStyle())
            case .truthOrDare:
                HStack(spacing: 16){
                    Button("Truth", action: {
                        model.truthHandler()
                        model.titleHandler()
                    }).buttonStyle(MainButtonStyle())
                    Button("Dare", action: {
                        model.dareHandler()
                        model.titleHandler()
                    }).buttonStyle(MainButtonStyle())
                }
            case .activity:
                Button("Next Player", action: {
                    model.status = .truthOrDare
                    model.incrementPlayer()
                    model.titleHandler()
                }).buttonStyle(MainButtonStyle())
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
                        Button(action: model.showRules) {
                            MenuLabel(.rules)
                        }
                    }
                    Section{
                        Button(action: {
                            model.selectTier(tier: .friendly)
                        }) {
                            MenuLabel(.tierFriendly(model.tier == .friendly))
                        }
                        Button(action: {
                            model.selectTier(tier: .challenging)
                        }) {
                            MenuLabel(.tierChallenging(model.tier == .challenging))
                        }
                        Button(action: {
                            model.selectTier(tier: .naughty)
                        }) {
                            MenuLabel(.tierNaughty(model.tier == .naughty))
                        }
                    }
                }, label: {
                    GameMenuButton()
                })
//
            }
        }
        .sheet(isPresented: $model.isRulesOpen) {
            RuleView(isOpen: $model.isRulesOpen)
        }
        .onAppear{
            model.fetchTruth()
            model.fetchDare()
        }
    }
    

}
