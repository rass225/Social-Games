import Foundation
import SwiftUI

struct GameButtonModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    let color: Color
    
    init(game: Games) {
        let appearance = Appearance()
        color = appearance.color(game)
    }
    func body(content: Content) -> some View {
        switch colorScheme {
        case .light:
            content
                .background(Material.ultraThinMaterial)
                .cornerRadius(16)
            //                .shadow(color: Color.gray.opacity(1), radius: 3, x: 0, y: 0)
        case .dark:
            content
                .background(.white.opacity(0.3))
                .cornerRadius(16)
        @unknown default:
            content
                .background(color)
                .cornerRadius(16)
                .shadow(color: Color.gray.opacity(1), radius: 3, x: 0, y: 0)
            
        }
    }
}

struct GameSymbolModifier: ViewModifier {
    let game: Games
    private let appearance = Appearance()
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(appearance.color(game))
    }
}

struct GameButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.6 : 1.0)
            .animation(.default, value: configuration.isPressed)
    }
}

struct MainButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(BlurEffect())
            .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
//            .shadow(color: Colors.darkShadow, radius: 15, x: 0, y: 10)
    }
}
