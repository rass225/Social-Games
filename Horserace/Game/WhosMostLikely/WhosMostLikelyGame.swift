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
            HStack(spacing: 0){
                Button(action: {
                    model.selectTier(tier: .friendly)
                }) {
                    Text("Friendly")
                        .maxWidth()
                        .foregroundColor(model.tier == .friendly ? .white : .gray)
                        .font(.subheadline.weight(.regular))
                }
                Divider().background(.white)
                Button(action: {
                    model.selectTier(tier: .challenging)
                }) {
                    Text("Challenging")
                        .maxWidth()
                        .foregroundColor(model.tier == .challenging ? .white : .gray)
                        .font(.subheadline.weight(.medium))
                }
            }
            .frame(maxHeight: 36)
            .background(game.game.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.top, 8)
            GeometryReader { geo in
                let size = geo.size
                let desiredWidth = size.width / 1.3
                if model.status == .activity {
                    Ticket(desiredWidth: desiredWidth, title: $model.currentTitle, subtitle: $model.currentStatement, footnote: model.tier.rawValue)
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
        .gameViewModifier(game: .whosMostLikely)
        .navigationModifier(game: .whosMostLikely)
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
            model.fetchWhosMostLikely()
        }
    }
}
