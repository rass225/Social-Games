import SwiftUI

struct NeverHaveIEverGame: View {
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: NeverEverModel
    
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
            Button(model.mainButtonLabel, action: model.mainButtonAction)
                .buttonStyle(MainButtonStyle())
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
            }
        }
        .sheet(isPresented: $model.isRulesOpen) {
            RuleView(isOpen: $model.isRulesOpen)
        }
        .onAppear{
            model.fetchNeverHaveIEver()
        }
    }
}



