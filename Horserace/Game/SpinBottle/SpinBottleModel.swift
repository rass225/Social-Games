import Foundation
import SwiftUI

class SpinBottleModel: ObservableObject {
    
    @Published var spinDegrees: Double = 0.0
    @Published var hasGameStarted: Bool = false
    private var rand: Double = 0.0
    private var newAngle: Double = 0.0
    
    func spinBottle(value: Double) {
        print(value)
        hasGameStarted = true
        rand = Double.random(in: 1...540)
        if value < 0 {
            spinDegrees += value * -3
        } else {
            spinDegrees += value * 3
        }
        
        newAngle = getAngle(angle: spinDegrees)
    }
    
    func getAngle(angle: Double) -> Double {
        let deg = 360 - angle.truncatingRemainder(dividingBy: 360)
        return deg
    }
}
