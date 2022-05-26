import SwiftUI

struct RulesButton: View {
    
    @EnvironmentObject var game: Game
    @Binding var isOpen: Bool
    
    var body: some View {
        Button(action: {
            isOpen.toggle()
        }) {
            Images.rulesCircleFill
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, game.game.gradient)
                .font(.title)
        }
    }
}
