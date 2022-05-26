import SwiftUI

struct EditButton: View {
    
    @EnvironmentObject var game: Game
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Images.edit
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, game.game.gradient)
                .font(.title)
        }
    }
}
