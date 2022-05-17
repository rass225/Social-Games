import Foundation
import SwiftUI

enum Gradients {
    static let chooserCircle = Gradient(colors: [.white, .orange, .red, .init(red: 0.5, green: 0, blue: 0)])
    static let chooseCircle2 = AngularGradient(colors: [Colors.mint, Colors.cyan, Colors.mint, Colors.cyan, Colors.mint], center: .center, angle: Angle(degrees: 300))
    static let backgroundBottomLayer = AngularGradient(colors: Colors.backgroundBottomLayersColors, center: .center, angle: Angle(degrees: 90))
    static let backgroundTopLayer = LinearGradient(gradient: Gradient(colors: Colors.backgroundTopLayerColors), startPoint: .top, endPoint: .bottom)

}
