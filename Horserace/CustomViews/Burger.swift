import SwiftUI

struct Burger: View {
    
    @EnvironmentObject var game: Game
    
    var body: some View {
        Images.burgerFill
            .symbolRenderingMode(.palette)
            .foregroundStyle(Colors.text, .thinMaterial)
            
            .font(.title)
//            .overlay(Circle().stroke(lineWidth: 1).fill(Colors.buttonBorder))
    }
}
