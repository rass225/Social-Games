import SwiftUI

struct GameMenuButton: View {
    
    @EnvironmentObject var game: Game
    
    var body: some View {
        Image(systemName: "line.3.horizontal.decrease.circle.fill")
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, game.game.gradient)
            .font(.title)
    }
}
