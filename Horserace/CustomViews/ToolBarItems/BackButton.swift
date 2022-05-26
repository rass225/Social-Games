import Foundation
import SwiftUI

struct BackButton: View {
    
    @EnvironmentObject var game: Game
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Images.back
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, game.game.gradient)
                .font(.title)
        }
    }
}
