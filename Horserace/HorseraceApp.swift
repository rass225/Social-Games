import SwiftUI

@main
struct HorseraceApp: App {
    
    @ObservedObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .id(appState.rootViewId)
                .statusBar(hidden: true)
        }
    }
}
