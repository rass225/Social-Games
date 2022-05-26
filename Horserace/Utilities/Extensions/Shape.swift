import Foundation
import SwiftUI

extension Shape {
    public func fill<S:ShapeStyle>(_ fillContent: S, stroke: StrokeStyle, color: Color) -> some View {
        ZStack {
            self.fill(fillContent)
            self.stroke(color, style:stroke)
        }
    }
}
