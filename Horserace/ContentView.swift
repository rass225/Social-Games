//import SwiftUI
import SwiftUI

struct ContentView: View {
    
    @State var showingAlert = false
    @State var alertMessage = "This game is being developed and will be released in the coming weeks"
    
    var body: some View {
        NavigationView{
            ZStack{
                DefaultBackground()
                content
            }
            .navigationBarHidden(true)
        }.accentColor(.white)
    }

    
    var content: some View {
        GeometryReader { geometry in
            //                let size = (geometry.size.width / 2) - 8
            let size = geometry.size
            ScrollView(showsIndicators: false){
               
                VStack(spacing: 24){
                    HStack(spacing: 24){
                        GameView(.pyramid, size: size, willPulse: true)
                        GameView(.spinBottle, size: size, tilt: 25, willRotate: true)
                    }
                    HStack(spacing: 24){
                        GameView(.kingsCup, size: size, willPulse: true)
                        GameView(.horseRace, size: size, willPulse: true)
                    }
                    HStack(spacing: 24){
                        GameView(.chooser, size: size, willPulse: true)
                        GameView(.roulette, size: size, willRotate: true)
                    }
                    HStack(spacing: 24){
                        GameView(.wheel, size: size, willRotate: true)
                        GameView(.explain, size: size, willPulse: true)
                            .isGameDisabled($showingAlert)
                    }
                    HStack(spacing: 24){
                        GameView(.truthDare, size: size)
                            .isGameDisabled($showingAlert)
                        GameView(.neverHaveIEver, size: size)
                            .isGameDisabled($showingAlert)
                    }
                    HStack(spacing: 24){
                        GameView(.higherLower, size: size)
                            .isGameDisabled($showingAlert)
                        GameView(.whosMostLikely, size: size)
                            .isGameDisabled($showingAlert)
                    }
                    
                }
                .padding(.horizontal, 24)
                .padding(.top, 32)
                .padding(.bottom, 32)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Coming Soon"), message: Text(alertMessage), dismissButton: .default(Text("Done")))
        }
        
    }
    
    private struct GameView: View {
        let appearance = Appearance()
        let size: CGSize
        let game: Games
        let tilt: Angle
        let willPulse: Bool
        let willRotete: Bool
        @State var isPulsing: Bool = false
        @State var isRotating: Bool = false
        @State var rotationAngle: Angle = Angle(degrees: 0)
        
        var hasQuestionMark: Bool = false
        var foreverAnimation: Animation {
            Animation.linear(duration: 12.0)
                .repeatForever(autoreverses: false)
        }
        var pulseAnimation: Animation {
            Animation.linear(duration: 1.5)
                .repeatForever(autoreverses: true)
        }
        
        init(
            _ game: Games,
            size: CGSize,
            tilt: Double = 0,
            willRotate: Bool = false,
            willPulse: Bool = false
            
        ) {
            self.size = size
            self.game = game
            self.tilt = Angle(degrees: tilt)
            self.willRotete = willRotate
            self.willPulse = willPulse
            switch game {
            case .truthDare, .neverHaveIEver, .whosMostLikely:
                hasQuestionMark = true
            default:
                break
            }
        }
        
        var body: some View {
            NavigationLink(destination: GameSetup(game: game)) {
                ZStack{
                    appearance.icon(game)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: size.width / 4)
                        .frame(maxHeight: size.width / 4)
                        .foregroundColor(appearance.color(game))
                        .rotationEffect(tilt)
                        .rotationEffect(Angle(degrees: isRotating ? 360.0 : 0.0))
                        .scaleEffect(isPulsing ? 0.92 : 1)
                        .animation(foreverAnimation, value: isRotating)
                        .animation(pulseAnimation, value: isPulsing)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                if willRotete {
                                    self.isRotating = true
                                }
                                if willPulse {
                                    self.isPulsing = true
                                }
                            }
                            
                        }
                        .overlay{
                            if hasQuestionMark {
                                Image(systemName: "questionmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: size.width / 8)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                }
                .maxHeight()
                .frame(maxWidth: .infinity)
                .frame(idealHeight: size.width / 2.3, maxHeight: size.width / 2)
                
                .overlay(alignment: .top) {
                    Text(game.rawValue)
                        .font(.headline.weight(.medium))
                        .foregroundColor(Colors.text)
                        .padding(.top, 16)
                }
                
                .background(BlurEffect())
                .mask(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
                .shadow(color: Colors.darkShadow, radius: 15, x: 0, y: 10)
            }.buttonStyle(GameButtonStyle())
        }
    }
    
    private struct NewGameView: View {
        let appearance = Appearance()
        let size: CGSize
        let game: Games
        let tilt: Angle
        let willPulse: Bool
        let willRotete: Bool
        let image: Image
        @State var isPulsing: Bool = false
        @State var isRotating: Bool = false
        @State var rotationAngle: Angle = Angle(degrees: 0)
        
        var hasQuestionMark: Bool = false
        var foreverAnimation: Animation {
            Animation.linear(duration: 12.0)
                .repeatForever(autoreverses: false)
        }
        var pulseAnimation: Animation {
            Animation.linear(duration: 1.5)
                .repeatForever(autoreverses: true)
        }
        
        init(
            _ game: Games,
            size: CGSize,
            tilt: Double = 0,
            willRotate: Bool = false,
            willPulse: Bool = false
            
        ) {
            self.size = size
            self.game = game
            self.tilt = Angle(degrees: tilt)
            self.willRotete = willRotate
            self.willPulse = willPulse
            switch game {
            case .truthDare, .neverHaveIEver, .whosMostLikely:
                hasQuestionMark = true
            default:
                break
            }
            switch game {
            case .horseRace:
                image = Images.horseBig
            case .kingsCup:
                image = Images.edit
            case .truthDare:
                image = Images.edit
            case .neverHaveIEver:
                image = Images.edit
            case .pyramid:
                image = Images.pyramidBig
            case .spinBottle:
                image = Images.edit
            case .whosMostLikely:
                image = Images.edit
            case .higherLower:
                image = Images.edit
            case .chooser:
                image = Images.edit
            case .explain:
                image = Images.edit
            case .roulette:
                image = Images.edit
            case .wheel:
                image = Images.edit
            }
        }
        
        var body: some View {
            NavigationLink(destination: GameSetup(game: game)) {
                VStack{
                    Spacer()
                    HStack{
                        appearance.icon(game)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                        appearance.title(game)
                            .font(.title3).bold()
                    }
                    .maxWidth(alignment: .leading)
                    .padding()
                    .background(.ultraThinMaterial)
                }
                .frame(maxWidth: .infinity)
                .frame(idealHeight: size.width / 1.5, maxHeight: size.width / 1.5)
                .background(
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .shadow(color: Colors.darkShadow, radius: 15, x: 0, y: 10)
            }.buttonStyle(GameButtonStyle())
        }
    }
}


