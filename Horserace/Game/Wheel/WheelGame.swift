import SwiftUI

struct WheelGame: View {
    @Environment(\.presentationMode) var presentationMode
    let players: [String]
    let components: [String]
    @State var currentPlayer: Int = 0
    @State var isRulesOpen: Bool = false
    var body: some View {
        VStack(spacing: 0){
            PlayersBoard(currentPlayer: $currentPlayer, players: players)
                .padding(.bottom, 32)
            GeometryReader { geo in
                let size = geo.size
                VStack{
                    Spacer()
                    FortuneWheel(titles: components, size: size, onSpinEnd: { i in
                        incrementPlayer()
                    })
                    Spacer()
                    Spacer()
                }
                
            }
            .padding(.horizontal)
        }
        .maxWidth()
        .navigationModifier(game: .wheel)
        .gameViewModifier(game: .wheel)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                MainMenuMenuButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Images.edit
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Colors.text, .thinMaterial)
                        .font(.title)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesMenuButton(isOpen: $isRulesOpen)
            }
            GameTitle(game: .wheel)
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
    }
    
    func incrementPlayer() {
        if currentPlayer == players.count - 1 {
            currentPlayer = 0
        } else {
            currentPlayer += 1
        }
    }
}
