import SwiftUI

struct HomeButton: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var game: Game
    var withDelay: Bool = false
    var body: some View {
        Button(action: {
            appState.toMainMenu(withDelay: withDelay)
        }) {
            Images.mainMenu
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, game.game.gradient)
                .font(.title)
        }
    }
}
