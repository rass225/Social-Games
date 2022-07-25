import SwiftUI

struct NeverHaveIEverGame: View {
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: NeverEverModel
    @State var isRulesOpen: Bool = false
    @State var hasPlayersShuffled: Bool = false
    @State var title: String = "Never Have I Ever"
    
    init() {
        self.model = NeverEverModel()
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
                    Ticket(desiredWidth: desiredWidth, title: title, subtitle: $model.currentStatement, footnote: model.tier.rawValue)
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
        .gameViewModifier(game: .neverHaveIEver)
        .navigationModifier(game: .neverHaveIEver)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
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



