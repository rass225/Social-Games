
import SwiftUI

struct GameTitle: View {
    @EnvironmentObject var game: Game
    
    var body: some View {
        game.game.title
            .font(.headline.weight(.medium))
            .foregroundColor(Colors.text)
    }
}
