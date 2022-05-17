import SwiftUI

struct DefaultBackground: View {

    var body: some View {
        ZStack{
            Gradients.backgroundBottomLayer
                .ignoresSafeArea()
            Gradients.backgroundTopLayer
                .ignoresSafeArea()
        }
    }
}

struct GameIconBackground: View {
    private let cyanLight: Color = .init(red: 15/255, green: 138/255, blue: 195/255)
    private let cyanDark: Color = .init(red: 0/255, green: 123/255, blue: 180/255)
    private let mintLight: Color = .init(red: 0, green: 164/255, blue: 155/255)
    private let mintDark: Color = .init(red: 0, green: 149/255, blue: 140/255)
    private let tealLight: Color = .init(red: 13/255, green: 141/255, blue: 164/255)
    private let tealDark: Color = .init(red: 0/255, green: 125/255, blue: 149/255)
    private let blueLight: Color = .init(red: 0, green: 87/255, blue: 220/255)
    private let blueDark: Color = .init(red: 0, green: 74/255, blue: 205/255)
    
    let color1: Color
    let color2: Color
    let color3: Color
    let color4: Color
    
    var colors: [Color]
    let game: Games
    
    private let angle: Angle = Angle(degrees: 300)
    
   
    private let appearance = Appearance()
    
    init(game: Games) {
        color1 = .init(light: cyanLight, dark: cyanDark)
        color2 = .init(light: mintLight, dark: mintDark)
        color3 = .init(light: tealLight, dark: tealDark)
        color4 = .init(light: blueLight, dark: blueDark)
        self.game = game
        colors = [color1, color2, color3]
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                LinearGradient(gradient: Gradient(colors: colors), startPoint: .bottomLeading, endPoint: .topTrailing)
                    .maxWidth()
                    
                    
                    .mask{
                        appearance.icon(game)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .maxWidth()
                            .frame(minHeight: 300, idealHeight: 400, maxHeight: 500)
                            .blur(radius: 10)
                            .rotationEffect(Angle(degrees: 25))
                    }
                Spacer()
            }
            
            
        }
    }
}
