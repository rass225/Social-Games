import Foundation
import SwiftUI
import UIKit

class Game: ObservableObject {
    
    @Published var game: Games
    @Published var color: Color
    @Published var title: Text
    
    private let appearance = Appearance()
    
    init(game: Games) {
        self.game = game
        self.color = appearance.color(game)
        self.title = appearance.title(game)
    }
}


public struct VisualEffectBlurView<Content: View>: UIViewRepresentable {
    public typealias UIViewType = UIView

    private let blurStyle: UIBlurEffect.Style
    private let vibrancyStyle: UIVibrancyEffectStyle?
    private let content: Content

    private var intensity: Double = 1.0
    private var opacity: Double = 1.0

    public init(
        blurStyle: UIBlurEffect.Style = .systemMaterial,
        vibrancyStyle: UIVibrancyEffectStyle? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.blurStyle = blurStyle
        self.vibrancyStyle = vibrancyStyle
        self.content = content()
    }

    public func makeUIView(context: Context) -> UIViewType {
        UIHostingVisualEffectBlurView<Content>(
            blurStyle: blurStyle,
            vibrancyStyle: vibrancyStyle,
            rootView: content,
            intensity: intensity
        )
    }

    public func updateUIView(_ view: UIViewType, context: Context) {
        guard let view = view as? UIHostingVisualEffectBlurView<Content> else {
            assertionFailure()

            return
        }

        view.blurStyle = blurStyle
        view.vibrancyStyle = vibrancyStyle
        view.alpha = .init(opacity)
        view.intensity = intensity
        view.rootView = content
    }
}

extension VisualEffectBlurView where Content == EmptyView {
    public init(blurStyle: UIBlurEffect.Style = .systemMaterial) {
        self.init(blurStyle: blurStyle, vibrancyStyle: nil) {
            EmptyView()
        }
    }
}

extension VisualEffectBlurView {
    /// Sets the intensity of the blur effect.
    public func intensity(_ intensity: Double) -> Self {
        then({ $0.intensity = intensity })
    }

    /// Sets the transparency of this view.
    public func opacity(_ opacity: Double) -> Self {
        then({ $0.opacity = opacity })
    }
}


class UIHostingVisualEffectBlurView<Content: View>: UIView {
    private let vibrancyView = UIVisualEffectView()
    private let blurView = UIVisualEffectView()
    private let hostingController: UIHostingController<Content>
    private var oldBlurStyle: UIBlurEffect.Style?
    private var oldVibrancyStyle: UIVibrancyEffectStyle?
    private var blurEffectAnimator: UIViewPropertyAnimator? = UIViewPropertyAnimator(duration: 1, curve: .linear)

    var rootView: Content {
        get {
            hostingController.rootView
        } set {
            hostingController.rootView = newValue
        }
    }

    var blurStyle: UIBlurEffect.Style {
        didSet {
            guard blurStyle != oldValue else {
                return
            }

            updateBlurAndVibrancyEffect()
        }
    }

    var vibrancyStyle: UIVibrancyEffectStyle? {
        didSet {
            guard vibrancyStyle != oldValue else {
                return
            }

            updateBlurAndVibrancyEffect()
        }
    }

    var intensity: Double {
        didSet {
            DispatchQueue.asyncOnMainIfNecessary {
                if let animator = self.blurEffectAnimator {
                    guard animator.fractionComplete != CGFloat(self.intensity) else {
                        return
                    }

                    animator.fractionComplete = CGFloat(self.intensity)
                }
            }
        }
    }

    init(
        blurStyle: UIBlurEffect.Style,
        vibrancyStyle: UIVibrancyEffectStyle?,
        rootView: Content,
        intensity: Double
    ) {
        self.blurStyle = blurStyle
        self.vibrancyStyle = vibrancyStyle
        self.intensity = intensity

        hostingController = UIHostingController(rootView: rootView)
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.view.backgroundColor = nil

        vibrancyView.contentView.addSubview(hostingController.view)
        vibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        blurView.contentView.addSubview(vibrancyView)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        super.init(frame: .zero)

        addSubview(blurView)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        updateBlurAndVibrancyEffect()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateBlurAndVibrancyEffect() {
        blurView.effect = nil
        vibrancyView.effect = nil

        blurEffectAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear)

        blurEffectAnimator?.stopAnimation(true)

        let blurEffect = UIBlurEffect(style: blurStyle)

        blurEffectAnimator?.addAnimations {
            self.blurView.effect = blurEffect
        }

        if let vibrancyStyle = vibrancyStyle {
            vibrancyView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: vibrancyStyle)
        } else {
            vibrancyView.effect = nil
        }

        hostingController.view.setNeedsDisplay()
    }

    deinit {
        blurEffectAnimator?.stopAnimation(true)
        blurEffectAnimator = nil
    }
}

extension DispatchQueue {
    @usableFromInline
    static func asyncOnMainIfNecessary(execute work: @escaping () -> ()) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}


extension View {
    @inlinable
    public func then(_ body: (inout Self) -> Void) -> Self {
        var result = self

        body(&result)

        return result
    }

    /// Returns a type-erased version of `self`.
    @inlinable
    public func eraseToAnyView() -> AnyView {
        return .init(self)
    }
}
