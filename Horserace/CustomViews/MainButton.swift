import SwiftUI

struct MainButton: View {
    
    @EnvironmentObject var game: Game
    let label: String
    
    var body : some View {
        Text(label)
            .font(Fonts.title3)
            .foregroundColor(.white)
            .maxWidth()
            .padding(.vertical)
            .background(game.game.gradient)
            .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(lineWidth: 0.5)
                .fill(Colors.buttonBorder)
            )
    }
}
