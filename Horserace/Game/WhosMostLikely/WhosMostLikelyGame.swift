import SwiftUI

struct WhosMostLikelyGame: View {
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: WhosMostLikelyModel
    @State var isRulesOpen: Bool = false
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
                    let desiredWidth = size.width / 1.25
                    Ticket(desiredWidth: desiredWidth, title: model.currentTitle, subtitle: $model.currentStatement, footnote: model.tier.rawValue)
                        .maxWidth()
                        .maxHeight()
                }
            }
            
            Button(action: {
                model.mainButtonAction()
            }) {
                MainButton(label: model.mainButtonLabel)
            }
        }
        .gameViewModifier(game: .whosMostLikely)
        .navigationModifier(game: .whosMostLikely)
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
                    }
                }, label: {
                    GameMenuButton()
                })
            }
            ToolbarItem(placement: .principal) {
                GameTitle()
            }
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
        .onAppear{
            model.fetchWhosMostLikely()
        }
    }
}
