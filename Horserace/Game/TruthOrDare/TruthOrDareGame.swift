import SwiftUI

struct TruthOrDareGame: View {
    
    @ObservedObject var model: TruthOrDareModel
    @State var isRulesOpen: Bool = false
    @State var hasPlayersShuffled: Bool = false
    init(players: [String]) {
        self.model = TruthOrDareModel(players: players)
    }
    
    var body: some View {
        VStack{
            PlayersBoard(currentPlayer: $model.currentPlayer, hasPlayersShuffled: $hasPlayersShuffled, players: model.players)
            
            VStack(alignment: .center, spacing: 0){
                TitleLabel(label: model.title)
                if model.status == .activity {
                    Text(model.label)
                        .padding(.top, 32)
                        .font(.title2.weight(.regular))
                }
            }
            .maxWidth()
            .padding(.top, 32)
            Spacer()
            
            switch model.status {
            case .notStarted:
                Button(action: {
                    model.status = .truthOrDare
                    model.incrementPlayer()
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    RulesMenuButton(isOpen: $isRulesOpen)
                    Button(action: {
                        model.restart()
                    }) {
                        Text("Was Menu label")
                    }
                    MainMenuMenuButton()
                }, label: {
                    Text("Was Burger")
                })
            }
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
    }
}
