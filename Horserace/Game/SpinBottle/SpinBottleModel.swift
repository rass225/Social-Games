import Foundation
import SwiftUI

class SpinBottleModel: ObservableObject {
    
    @Published var currentPlayer: Int = 0
    @Published var spinDegrees: Double = 0.0
    @Published var hasGameStarted: Bool = false
    private var rand: Double = 0.0
    private var newAngle: Double = 0.0
    @Published var isAnimating: Bool = false
    
    func spinBottle() {
        hasGameStarted = true
        rand = Double.random(in: 1...540)
        spinDegrees += 1260.0 + rand
        newAngle = getAngle(angle: spinDegrees)
    }
    
    func getAngle(angle: Double) -> Double {
        let deg = 360 - angle.truncatingRemainder(dividingBy: 360)
        return deg
    }
}
