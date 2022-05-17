import Foundation
import SwiftUI

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
    }
}

struct BlurEffectModifier: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .overlay(_BlurVisualEffectViewRepresentable())
    }
}



struct _BlurVisualEffectViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: context.environment.blurEffectStyle))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: context.environment.blurEffectStyle)
    }
}




struct BlurEffectStyleKey: EnvironmentKey {
    static var defaultValue: UIBlurEffect.Style = .systemThinMaterial // (Per the human-interface guidelines.)
}

public struct BlurEffect: View {
    public init() {}
    
    public var body: some View {
        _BlurVisualEffectViewRepresentable()
    }
}
