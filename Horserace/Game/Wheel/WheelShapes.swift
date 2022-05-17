import Foundation
import SwiftUI

struct Triangle: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.minY), control1: CGPoint(x: rect.maxX, y: rect.minY), control2: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}
