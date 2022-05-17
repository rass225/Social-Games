import Foundation
import SwiftUI

enum Images {
    static let heart = Image(systemName: "suit.heart.fill")
    static let diamond = Image(systemName: "suit.diamond.fill")
    static let club = Image(systemName: "suit.club.fill")
    static let spade = Image(systemName: "suit.spade.fill")
    static let restart = Image(systemName: "arrow.clockwise")
    static let mainMenu = Image(systemName: "house")
    static let burger = Image(systemName: "line.3.horizontal")
    static let burgerFill = Image(systemName: "line.3.horizontal.circle.fill")
    static let rules = Image(systemName: "doc.text")
    static let rulesFill = Image(systemName: "doc.text.fill")
    static let crown = Image(systemName: "crown.fill")
    static let hexagon = Image(systemName: "hexagon.fill")
    static let pentagon = Image(systemName: "pentagon.fill")
    static let seal = Image(systemName: "seal.fill")
    static let pyramid = Image(systemName: "pyramid.fill")
    static let explain = Image(systemName: "person.wave.2")
    static let higherLower = Image(systemName: "arrow.up.arrow.down.circle.fill")
    static let chooser = Image(systemName: "dot.circle.and.hand.point.up.left.fill")
    static let bottle = Image("Bottle")
    static let horse = Image("Horse")
    static let roulette = Image("Roulette")
    static let wheel = Image(systemName: "gearshape.fill")
    
    enum Nr {
        static let one = Image(systemName: "1.circle")
        static let two = Image(systemName: "2.circle")
        static let three = Image(systemName: "3.circle")
        static let four = Image(systemName: "4.circle")
        static let five = Image(systemName: "5.circle")
        static let six = Image(systemName: "6.circle")
        static let seven = Image(systemName: "7.circle")
        static let eight = Image(systemName: "8.circle")
        static let nine = Image(systemName: "9.circle")
    }
}

enum Fonts {
    static let largeTitle = Font.largeTitle.weight(.regular)
    static let title = Font.title.weight(.medium)
    static let title3 = Font.title3.weight(.regular)
}

enum Colors {
    static let text = Color(light: .black, dark: .white)
    static let reverseText = Color(light: .white, dark: .black)
    static let background = Color(light: .white, dark: .init(red: 0.2, green: 0.2, blue: 0.2))
    static let darkShadow = Color(light: .black.opacity(0.2), dark: .black.opacity(0.3))
    static let buttonBorder = Color(light: .white.opacity(0), dark: .white.opacity(0))
    static let mainColor = Color(light: Light.blue, dark: .mint)
    
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

    static let backgroundBottomLayersColors: [Color] = [red, orange, green, cyan, teal, red]
    static let backgroundTopLayerColors: [Color] = [Color.white.opacity(0.3), Color.white.opacity(0.5)]
    
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
}

enum Gradients {
    static let chooserCircle = Gradient(colors: [.white, .orange, .red, .init(red: 0.5, green: 0, blue: 0)])
    static let chooseCircle2 = AngularGradient(colors: [Colors.mint, Colors.cyan, Colors.mint, Colors.cyan, Colors.mint], center: .center, angle: Angle(degrees: 300))
    static let backgroundBottomLayer = AngularGradient(colors: Colors.backgroundBottomLayersColors, center: .center, angle: Angle(degrees: 90))
    static let backgroundTopLayer = LinearGradient(gradient: Gradient(colors: Colors.backgroundTopLayerColors), startPoint: .top, endPoint: .bottom)

}
