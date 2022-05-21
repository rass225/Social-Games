
import SwiftUI

struct GameTitle: ToolbarContent {
    let game: Games
    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            game.title
                .font(.headline.weight(.medium))
                .foregroundColor(Colors.text)
        }
    }
}
