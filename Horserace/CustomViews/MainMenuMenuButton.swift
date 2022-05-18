import SwiftUI

struct MainMenuMenuButton: View {
    
    @EnvironmentObject var appState: AppState
    var withDelay: Bool = false
    var body: some View {
        Button(action: {
            appState.toMainMenu(withDelay: withDelay)
        }) {
            Images.mainMenu
                .symbolRenderingMode(.palette)
                .foregroundStyle(Colors.text, .thinMaterial)
                
                .font(.title)
        }
    }
}
