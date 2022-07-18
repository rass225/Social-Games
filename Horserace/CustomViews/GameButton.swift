import SwiftUI

struct GameButton: View {
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
        Animation.linear(duration: 20.0).repeatForever(autoreverses: false)
    }
    var foreverAnimation2: Animation {
        Animation.linear(duration: 15.0).repeatForever(autoreverses: false)
    }
    var pulseAnimation: Animation {
        Animation.linear(duration: 2.5).repeatForever(autoreverses: true)
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
        case .truthDare, .neverHaveIEver, .whosMostLikely, .trivia, .millionaire:
            hasQuestionMark = true
        default:
            break
        }
    }
    
    var body: some View {
        NavigationLink(destination: GameSetup(game: game)) {
            gameIconBig
                .frame(idealWidth: size.width / 1.7, maxWidth: size.width / 1.7)
                .frame(idealHeight: size.width / 1.4, maxHeight: size.width / 1.4)
                .background(background)
                .mask(RoundCorners(cornerRadius: 24))
                .shadow(color: Colors.darkShadow, radius: 5, x: 0, y: 8)
                .overlay(alignment: .bottomLeading) {
                    gameTitle
                }
                .overlay(alignment: .topLeading) {
                    VStack(alignment: .leading, spacing: 0){
                        gameIcon
                        HStack(spacing: 4) {
                            game.maxPlayers.image
                                .font(.subheadline.weight(.bold))
                            Text("players max")
                                .textCase(.uppercase)
                                .font(.subheadline.weight(.bold))
                        }
                        .padding(.horizontal)
                        .foregroundColor(game.color)
                        .opacity(0.9)
                    }
                }.onAppear(perform: startAnimation)
        }.buttonStyle(GameButtonStyle())
    }
    
    var gameIconBig: some View {
        game.icon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: size.width / 1.5, maxHeight: size.width / 1.5)
            .foregroundColor(.white.opacity(0.1))
            .rotationEffect(Angle(degrees: isRotating ? 360.0 : 0.0))
            .scaleEffect(isPulsing ? 0.90 : 1)
            .animation(foreverAnimation, value: isRotating)
            .animation(pulseAnimation, value: isPulsing)
            .offset(x: size.width / 6, y: size.width / 6)
    }
    
    var gameTitle: some View {
        game.title
            .font(.title2.weight(.semibold))
            .foregroundColor(.white)
            .tracking(0.5)
            .padding(.vertical, 24)
            .padding(.horizontal)
            .maxWidth(alignment: .leading)
    }
    
    var gameIcon: some View {
        game.icon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: size.width / 12)
            .frame(maxHeight: size.width / 12)
            .foregroundColor(game.color)
            .rotationEffect(tilt)
            .animation(pulseAnimation, value: isPulsing)
            .padding(16)
            .overlay{
                if hasQuestionMark {
                    questionMark
                }
            }
    }
    
    var background: some View {
        ZStack{
            game.gradient
            LinearGradient(stops: [
                .init(color: .clear, location: 0),
                .init(color: .clear, location: 0.4),
                .init(color: .black.opacity(0.8), location: 1)
            ], startPoint: .top, endPoint: .bottom)
        }
    }
    
    var questionMark: some View {
        Images.questionMark
            .font(.body.weight(.bold))
            .foregroundColor(.white)
    }
    
    func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if willRotete {
                self.isRotating = true
            }
            if willPulse {
                self.isPulsing = true
            }
        }
    }
}
