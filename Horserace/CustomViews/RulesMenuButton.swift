import SwiftUI

struct RulesMenuButton: View {
    
    @EnvironmentObject var game: Game
    @Binding var isOpen: Bool
    
    var body: some View {
        Button(action: {
            isOpen.toggle()
        }) {
            Images.rulesCircleFill
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, game.game.gradient)
                
                .font(.title)
        }
    }
}


struct BackButton: View {
    
    @EnvironmentObject var game: Game
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }) {
            
            Image(systemName: "chevron.left.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, LinearGradient(gradient: Gradient(colors: game.game.background), startPoint: .bottom, endPoint: .top))
                
                .font(.title)
        }
        
    }
}
