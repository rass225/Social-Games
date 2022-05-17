import SwiftUI

struct RulesMenuButton: View {
    
    @Binding var isOpen: Bool
    
    var body: some View {
        Button(action: {
            isOpen.toggle()
        }) {
            MenuLabel(type: .rules)
        }
    }
}
