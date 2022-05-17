import Foundation
import SwiftUI

final class AppState : ObservableObject {
    
    @Published var rootViewId = UUID()
    
    func toMainMenu(withDelay: Bool = false) {
        if withDelay {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.rootViewId = UUID()
            }
        } else {
            self.rootViewId = UUID()
        }
    }
}


