import SwiftUI

struct WhosMostLikelyGame: View {
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: WhosMostLikelyModel
    @State var hasPlayersShuffled: Bool = false
    
    init() {
        model = WhosMostLikelyModel()
    }
    
    var body: some View {
        VStack{
            switch model.status {
            case .notStarted:
                Spacer()
                Text(model.currentTitle)
                    .font(.title.weight(.semibold))
                    .foregroundColor(Colors.text)
                    .maxWidth()
                Spacer()
            case .activity:
                GeometryReader { geo in
                    let size = geo.size
                    let desiredWidth = size.width / 1.20
                    Ticket(desiredWidth: desiredWidth, title: model.currentTitle, subtitle: $model.currentStatement, footnote: model.tier.rawValue)
                        .maxWidth()
                        .maxHeight()
                }
            }
            
            Button(model.mainButtonLabel ,action: model.mainButtonAction)
                .buttonStyle(MainButtonStyle())
        }
        .gameViewModifier(game: .whosMostLikely)
        .navigationModifier(game: .whosMostLikely)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
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
                    }
                }, label: {
                    GameMenuButton()
                })
            }
        }
        .sheet(isPresented: $model.isRulesOpen) {
            RuleView(isOpen: $model.isRulesOpen)
        }
        .onAppear{
            model.fetchWhosMostLikely()
        }
    }
}
