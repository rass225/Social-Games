
import SwiftUI

struct GameTitle: ToolbarContent {
    
    private let appearance = Appearance()
    let game: Games
    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            appearance.title(game)
                .font(.headline.weight(.regular))
                .foregroundColor(Colors.text)
        }
    }
}
