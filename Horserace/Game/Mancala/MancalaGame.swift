import SwiftUI

struct MancalaGame: View {
    
    @State var isRulesOpen = false
    @State var players: [String]
    @State var currentPlayer: Int = 0
    @State var hasPlayersShuffled: Bool = false
    
    var body: some View {
        VStack{
//            Text(players[0])
//                .rotationEffect(Angle(degrees: 180))
            Spacer()
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .frame(height: 70)
                .padding(.horizontal, 32)
            HStack{
                VStack{
                    Circle()
                    Circle()
                    Circle()
                    Circle()
                    Circle()
                    Circle()
                }
                
                VStack{
                    Circle()
                    Circle()
                    Circle()
                    Circle()
                    Circle()
                    Circle()
                }
            }
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .frame(height: 70)
                .padding(.horizontal, 32)
//            Text(players[1])
        }
        .navigationBarHidden(true)
        .navigationModifier(game: .mancala)
        .padding(.horizontal, 20)
        
        .background(DefaultBackground())
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
