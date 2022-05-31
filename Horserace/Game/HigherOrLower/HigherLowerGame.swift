import SwiftUI

struct HigherLowerGame: View {
    
    @ObservedObject var model: HigherLowerModel
    @State var isRulesOpen: Bool = false
    
    init(players: [String]) {
        model = HigherLowerModel(players: players)
    }
    
    var body: some View {
        VStack{
            PlayersBoard(currentPlayer: $model.currentPlayer, hasPlayersShuffled: $model.hasPlayersShuffled, players: model.players)
            
            GeometryReader { geo in
                let size = geo.size
                
                TitleLabel(label: "Higher or lower?")
                    .maxWidth(alignment: .center)
                    .padding(.top, 32)
                VStack{
                    Spacer()
                    HStack(spacing: 16){
                        FullCard(card: $model.deck[0], rotation: $model.testRotation, size: .large, geo: size)
                        FullCard(card: $model.deck[1], rotation: $model.testRotation, size: .large, geo: size)
                    }
                    .maxWidth()
                    .padding(.bottom)
                    Spacer()
                }
                VStack{
                    Spacer()
                    HStack(spacing: 16){
                        Button(action: {
                            
                        }) {
                            MainButton(label: "Higher")
                        }
                        Button(action: {
                            
                        }) {
                            MainButton(label: "Lower")
                        }
                    }
                }
            }
        }
        .navigationModifier(game: .higherLower)
        .gameViewModifier(game: .higherLower)
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
    }
}
