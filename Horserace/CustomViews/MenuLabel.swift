import SwiftUI

struct MenuLabel: View {
    
    enum LabelType: String {
        case rules = "Rules"
        case restart = "Restart"
        case mainMenu = "Main Menu"
    }
    let type: LabelType
    
    var body: some View {
        Text(type.rawValue)
        switch type {
        case .rules:
            Images.rules
        case .restart:
            Images.restart
        case .mainMenu:
            Images.mainMenu
        }
    }
}
