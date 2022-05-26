import SwiftUI

struct RestartButton: View {
    
    @EnvironmentObject var game: Game
    
    var body: some View {
        Images.restartFill
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, game.game.gradient)
            .font(.title)
    }
}
