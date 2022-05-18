import SwiftUI

struct RulesMenuButton: View {
    
    @Binding var isOpen: Bool
    
    var body: some View {
        Button(action: {
            isOpen.toggle()
        }) {
            Images.rulesCircleFill
                .symbolRenderingMode(.palette)
                .foregroundStyle(Colors.text, .thinMaterial)
                
                .font(.title)
        }
    }
}
