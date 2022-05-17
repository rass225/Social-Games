import UIKit
import SwiftUI

struct _BlurVisualEffectViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: context.environment.blurEffectStyle))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: context.environment.blurEffectStyle)
    }
}

public extension View {
    /**
    Sets the style for blur effects within this view.
    
    To set a specific style for all blur effects and vibrancy effects containing blur effects within a view, use the `blurEffectStyle(_:)` modifier:
    ```
    ZStack {
        backgroundContent
            .blurEffect()
        
        foregroundContent
            .vibrancyEffect()
    }
    .blurEffectStyle(.systemMaterial)
    ```
    */
    func blurEffectStyle(_ style: UIBlurEffect.Style) -> some View {
        environment(\.blurEffectStyle, style)
    }
}


public extension View {
    /// Creates a blur effect.
    func blurEffect() -> some View {
        ModifiedContent(content: self, modifier: BlurEffectModifier())
    }
}

public struct BlurEffectModifier: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .overlay(_BlurVisualEffectViewRepresentable())
    }
}

extension EnvironmentValues {
    var blurEffectStyle: UIBlurEffect.Style {
        get {
            self[BlurEffectStyleKey.self]
        }
        set {
            self[BlurEffectStyleKey.self] = newValue
        }
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
