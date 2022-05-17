import Foundation
import SwiftUI
import UIKit

class NFingerGestureRecognizer: UIGestureRecognizer {
    
    //    var tappedCallback: (UITouch, CGPoint?) -> Void
    var tappedCallback: ([UITouch:CGPoint], Bool) -> Void
    
    private var touchViews = [UITouch:CGPoint]()
    private var hasWinner = false
    private var winnerTouch = [UITouch: CGPoint]()
    private var currCount: Int = 0
    private var countdown: Timer?
    
    init(target: Any?, tappedCallback: @escaping ([UITouch:CGPoint], Bool) -> ()) {
        self.tappedCallback = tappedCallback
        super.init(target: target, action: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        for touch in touches {
            if !hasWinner {
                let location = touch.location(in: touch.view)
                touchViews[touch] = location
                removeAllWhenNeeded()
                stopCountdown()
                if shouldStartCountdown() {
                    startCountdown()
                }
                submitTouches()
                tappedCallback(touchViews, false)
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        for touch in touches {
            let newLocation = touch.location(in: touch.view)
            touchViews[touch] = newLocation
            submitTouches()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        for touch in touches {
            touchViews.removeValue(forKey: touch)
            stopCountdown()
            if shouldStartCountdown() {
                startCountdown()
            }
            
            if touchViews.isEmpty {
                hasWinner = false
            }
            submitTouches()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchViews.removeAll()
        tappedCallback(touchViews, false)
    }
    
    func removeAllWhenNeeded() {
        if touchViews.count > 5 {
            touchViews.removeAll()
        }
    }
    
    private func startCountdown() {
        if shouldStartCountdown() {
            countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleCountdown), userInfo: nil, repeats: true)
        }
    }
    
    private func stopCountdown() {
        countdown?.invalidate()
        currCount = 0
    }
    
    @objc private func handleCountdown(_ sender: Timer) {
        if currCount == 1 {
            stopCountdown()
            print("Winner winner chicken dinner")
            let winner = touchViews.randomElement()?.key
            for item in touchViews {
                if item.key != winner {
                    touchViews.removeValue(forKey: item.key)
                }
            }
            hasWinner = true
            winnerTouch = touchViews
            submitTouches()
        } else {
            currCount += 1
        }
    }
    
    private func shouldStartCountdown() -> Bool {
        return touchViews.count > 1
    }
    
    private func submitTouches() {
        if hasWinner {
            tappedCallback(winnerTouch, false)
        } else {
            tappedCallback(touchViews, false)
        }
       
    }
}
