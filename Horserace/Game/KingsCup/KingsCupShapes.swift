import Foundation
import SwiftUI

struct CupShape: Shape {
    func path(in rect: CGRect) -> Path {
        let height = rect.height
        let width = rect.height / 1.5
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width / 100 * 20, y: height))
        path.addLine(to: CGPoint(x: width / 100 * 80, y: height))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.closeSubpath()
        
        return path
    }
}

struct Wave: Shape {

    var offset: Angle
    var percent: Double = 0.9
    
//    var animatableData: Double {
//        get { percent }
//        set { percent = newValue }
//    }
    
    var animatableData: Double {
        get { offset.degrees }
        set { offset = Angle(degrees: newValue)}
    }
   
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let lowfudge = -0.1
        let highfudge = 0.98
        
        let newpercent = lowfudge + (highfudge - lowfudge) * percent
        let waveHeight = 0.03 * rect.height
        let yoffset = CGFloat(1 - newpercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 360)
        
        p.move(to: CGPoint(x: 0, y: yoffset + waveHeight * CGFloat(sin(startAngle.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yoffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        p.closeSubpath()
        
        return p
    }
}
