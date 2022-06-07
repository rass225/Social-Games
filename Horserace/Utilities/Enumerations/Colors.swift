import Foundation
import SwiftUI

enum Colors {
    static let text = Color(light: .black, dark: .white)
    static let reverseText = Color(light: .white, dark: .black)
    static let grayText = Color(light: .init(red: 0.3, green: 0.3, blue: 0.3), dark: .init(red: 0.7, green: 0.7, blue: 0.7))
    static let background = Color(light: .white, dark: .init(red: 0.1, green: 0.1, blue: 0.1))
    static let darkShadow = Color(light: .black.opacity(0.3), dark: .black.opacity(0.3))
    static let darkShadow2 = Color(light: .black.opacity(0.2), dark: .black.opacity(0.0))
    static let buttonBorder = Color(light: .white.opacity(0), dark: .white.opacity(0))
    static let mainColor = Color(light: Dark.blue, dark: Light.blue)
    
    static let test: Color = .init(red: 240/255, green: 135/255, blue: 90/255)

    static let backgroundBottomLayersColors: [Color] = [background]
    static let backgroundTopLayerColors: [Color] = [Color.white.opacity(0.1)]
    
    static let cyan: Color = .init(light: Light.cyan, dark: Dark.cyan)
    static let mint: Color = .init(light: Light.mint, dark: Dark.mint)
    static let teal: Color = .init(light: Light.teal, dark: Dark.teal)
    static let blue: Color = .init(light: Light.blue, dark: Dark.blue)
    static let green: Color = .init(light: Light.green, dark: Dark.green)
    static let yellow: Color = .init(light: Light.yellow, dark: Dark.yellow)
    static let orange: Color = .init(light: Light.orange, dark: Dark.orange)
    static let red: Color = .init(light: Light.red, dark: Dark.red)
    static let purple: Color = .init(light: Light.purple, dark: Dark.purple)
    static let indigo: Color = .init(light: Light.indigo, dark: Dark.indigo)
    
    enum Backgrounds {
        static let theme1: [Color] = [.init(red: 117/255, green: 52/255, blue: 34/255), .init(red: 176/255, green: 91/255, blue: 59/255)]
        static let theme2: [Color] = [.init(red: 37/255, green: 29/255, blue: 58/255), .init(red: 42/255, green: 37/255, blue: 80/255)]
        static let theme3: [Color] = [.init(red: 130/255, green: 149/255, blue: 75/255), .init(red: 186/255, green: 189/255, blue: 66/255)]
        static let theme4: [Color] = [.init(red: 84/255, green: 22/255, blue: 144/255), .init(red: 255/255, green: 73/255, blue: 73/255)]
        static let theme5: [Color] = [.init(red: 95/255, green: 113/255, blue: 97/255), .init(red: 109/255, green: 139/255, blue: 116/255)]
        static let theme6: [Color] = [.init(red: 17/255, green: 45/255, blue: 78/255), .init(red: 63/255, green: 114/255, blue: 175/255)]
        static let theme7: [Color] = [.init(red: 85/255, green: 104/255, blue: 168/255), .init(red: 209/255, green: 57/255, blue: 81/255)]
        static let theme8: [Color] = [.init(red: 31/255, green: 29/255, blue: 54/255), .init(red: 134/255, green: 72/255, blue: 121/255)]
        static let theme9: [Color] = [.init(red: 25/255, green: 26/255, blue: 25/255), .init(red: 30/255, green: 81/255, blue: 40/255)]
        static let theme10: [Color] = [.init(red: 178/255, green: 6/255, blue: 0), .init(red: 255/255, green: 95/255, blue: 0)]
        static let theme11: [Color] = [.init(red: 25/255, green: 35/255, blue: 30/255), .init(red: 30/255, green: 81/255, blue: 40/255)]
    }
    
    enum Foregrounds {
        static let theme1: Color = .init(red: 255/255, green: 235/255, blue: 201/255)
        static let theme2: Color = .init(red: 224/255, green: 77/255, blue: 1/255)
        static let theme3: Color = .init(red: 255/255, green: 239/255, blue: 130/255)
        static let theme4: Color = .init(red: 255/255, green: 225/255, blue: 200/255)
        static let theme5: Color = .init(red: 228/255, green: 221/255, blue: 232/255)
        static let theme6: Color = .init(red: 249/255, green: 247/255, blue: 247/255)
        static let theme7: Color = .init(red: 195/255, green: 248/255, blue: 235/255)
        static let theme8: Color = .init(red: 233/255, green: 166/255, blue: 166/255)
        static let theme9: Color = .init(red: 78/255, green: 159/255, blue: 61/255)
        static let theme10: Color = .init(red: 238/255, green: 230/255, blue: 238/255)
        static let theme11: Color = .init(red: 100/255, green: 179/255, blue: 91/255)
    }
    
    private enum Light {
        static let cyan: Color = .init(red: 15/255, green: 138/255, blue: 195/255)
        static let mint: Color = .init(red: 0, green: 164/255, blue: 155/255)
        static let teal: Color = .init(red: 13/255, green: 141/255, blue: 164/255)
        static let blue: Color = .init(red: 0, green: 87/255, blue: 220/255)
        static let green: Color = .init(red: 17/255, green: 165/255, blue: 54/255)
        static let yellow: Color = .init(red: 220/255, green: 169/255, blue: 0)
        static let orange: Color = .init(red: 220/255, green: 115/255, blue: 0)
        static let red: Color = .init(red: 220/255, green: 24/255, blue: 13/255)
        static let purple: Color = .init(red: 140/255, green: 47/255, blue: 187/255)
        static let indigo: Color = .init(red: 53/255, green: 51/255, blue: 179/255)
    }
   
    private enum Dark {
        static let cyan: Color = .init(red: 0/255, green: 113/255, blue: 170/255)
        static let mint: Color = .init(red: 0, green: 139/255, blue: 140/255)
        static let teal: Color = .init(red: 0/255, green: 115/255, blue: 139/255)
        static let blue: Color = .init(red: 0, green: 64/255, blue: 195/255)
        static let green: Color = .init(red: 0/255, green: 130/255, blue: 29/255)
        static let yellow: Color = .init(red: 195/255, green: 144/255, blue: 0)
        static let orange: Color = .init(red: 195/255, green: 90/255, blue: 0)
        static let red: Color = .init(red: 195/255, green: 0/255, blue: 0/255)
        static let purple: Color = .init(red: 115/255, green: 22/255, blue: 162/255)
        static let indigo: Color = .init(red: 28/255, green: 26/255, blue: 154/255)
    }
}
