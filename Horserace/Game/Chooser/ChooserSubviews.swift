import Foundation
import UIKit
import SwiftUI

struct TapView: UIViewRepresentable {

    var tappedCallback: ([UITouch:CGPoint], Bool) -> Void
    
    var interactionEnabled = true

    func makeUIView(context: UIViewRepresentableContext<TapView>) -> TapView.UIViewType {
        let v = UIView(frame: .zero)
        let gesture = NFingerGestureRecognizer(target: context.coordinator, tappedCallback: tappedCallback)
        v.addGestureRecognizer(gesture)
        v.isUserInteractionEnabled = interactionEnabled
        return v
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<TapView>) {

    }
    
    
}
