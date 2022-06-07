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
                        .foregroundColor(model.tier == .friendly ? game.game.color : .white)
                }
                Divider().background(.white)
                Button(action: {
                    model.selectTier(tier: .challenging)
                }) {
                    Text("Challenging")
                        .maxWidth()
                        .foregroundColor(model.tier == .challenging ? game.game.color : .white)
                }
                Divider().background(.white)
                Button(action: {
                    model.selectTier(tier: .naughty)
                }) {
                    Text("Naughty")
                        .maxWidth()
                        .foregroundColor(model.tier == .naughty ? game.game.color : .white)
                }
            }
            .font(.subheadline)
            .frame(maxHeight: 36)
            .background(game.game.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.top, 8)
            GeometryReader { geo in
                let size = geo.size
                if model.status == .activity {
                    VStack(alignment: .center){
                        VStack(alignment: .center, spacing: 16){
                            Text(model.title)
                                .font(.title3.weight(.semibold))
                                .foregroundColor(Colors.text)
                                .padding(.top)
                            Text(model.label)
                                .font(.body.weight(.regular))
                                .foregroundColor(.gray)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(width: size.width / 1.5)
                        .frame(height: size.height / 1.5)
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
//                        .shadow(color: Color.black.opacity(0.6), radius: 3, x: 0, y: 0)
                        .shadow(color: Colors.darkShadow2, radius: 5, x: 0, y: 8)
                    }
                    .maxWidth()
                    .maxHeight()
                   
                
//                    .padding(.top, size.height / 4)
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
