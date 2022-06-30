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
            HStack(spacing: 0){
                Button(action: {
                    model.selectTier(tier: .friendly)
                }) {
                    Text("Friendly")
                        .maxWidth()
                        .foregroundColor(model.tier == .friendly ? .white : .gray)
                }
                Divider().background(.white)
                Button(action: {
                    model.selectTier(tier: .challenging)
                }) {
                    Text("Challenging")
                        .maxWidth()
                        .foregroundColor(model.tier == .challenging ? .white : .gray)
                }
                Divider().background(.white)
                Button(action: {
                    model.selectTier(tier: .naughty)
                }) {
                    Text("Naughty")
                        .maxWidth()
                        .foregroundColor(model.tier == .naughty ? .white : .gray)
                }
            }
            .font(.subheadline.weight(.medium))
            .frame(maxHeight: 36)
            .background(game.game.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.top, 8)
            GeometryReader { geo in
                let size = geo.size
                let desiredWidth = size.width / 1.3
                if model.status == .activity {
                    Ticket(desiredWidth: desiredWidth, title: $model.title, subtitle: $model.label, footnote: model.tier.rawValue)
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
            model.fetchTruth()
            model.fetchDare()
        }
    }
}
