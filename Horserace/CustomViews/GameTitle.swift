
import SwiftUI

struct GameTitle: View {
    @EnvironmentObject var game: Game
    
    var body: some View {
//        Text("")
        game.game.title
            .textCase(.uppercase)
            .font(.callout.weight(.semibold))
            .foregroundColor(Colors.text)
    }
}
