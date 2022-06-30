import SwiftUI

struct ContentView: View {
    
    @State var showingAlert = false
    @State var alertMessage = "This game is being developed and will be released in the coming weeks"
    @State var spacing: Double = 20
    
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
            let size = geometry.size
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 12){
                    SectionHeader(title: "Card Games")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: spacing){
                            NewGameView(.horseRace, size: size)
                            NewGameView(.pyramid, size: size, willPulse: true)
                            NewGameView(.higherLower, size: size, willRotate: true)
                        }
                        .padding(.horizontal, spacing)
                        .padding(.bottom, spacing)
                    }
                }
                .padding(.top, 32)
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Spinning Games")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: spacing){
                            NewGameView(.spinBottle, size: size, tilt: 0, willRotate: true)
                            NewGameView(.roulette, size: size, willRotate: true)
                            NewGameView(.wheel, size: size, willRotate: true)
                        }
                        .padding(.horizontal, spacing)
                        .padding(.bottom, spacing)
                    }
                }
                .padding(.top, 32)
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Other Games")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: spacing){
                            NewGameView(.chooser, size: size, willPulse: true)
                            NewGameView(.mancala, size: size, tilt: -45, willPulse: true)
                                .isGameDisabled($showingAlert)
                        }
                        .padding(.horizontal, spacing)
                        .padding(.bottom, spacing)
                    }
                }.padding(.top, 32)
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Social Games")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: spacing){
                            NewGameView(.truthDare, size: size, willPulse: true)
                            NewGameView(.neverHaveIEver, size: size, willPulse: true)
                            NewGameView(.whosMostLikely, size: size)
                                
                            NewGameView(.explain, size: size, willPulse: true)
                                .isGameDisabled($showingAlert)
                        }
                        .padding(.horizontal, spacing)
                        .padding(.bottom, spacing)
                    }
                }.padding(.top, 32)
                copyright
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Coming Soon"), message: Text(alertMessage), dismissButton: .default(Text("Done")))
        }
    }
    
    var copyright: some View {
        VStack{
            Text("Copyright © 2022 Rasmus Tauts. All rights reserved.")
            Text("Designed and developed by Rasmus Tauts.")
        }
        .font(.footnote)
        .foregroundStyle(.gray)
        .padding(.top, 48)
        .padding(.bottom)
    }
    
    private struct SectionHeader: View {
        let title: String
        let spacing: CGFloat = 20
        var body: some View {
            Text(title)
                .font(.title.weight(.semibold))
                .padding(.horizontal, spacing)
        }
    }
    
    private struct NewGameView: View {
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
            case .truthDare, .neverHaveIEver, .whosMostLikely:
                hasQuestionMark = true
            default:
                break
            }
        }
        
        var body: some View {
            NavigationLink(destination: GameSetup(game: game)) {
                gameIconBig
                    .frame(idealWidth: size.width / 1.7, maxWidth: size.width / 1.7)
                    .frame(idealHeight: size.width / 2.2, maxHeight: size.width / 2.2)
                    .background(background)
                    .mask(RoundCorners(cornerRadius: 24))
                    .shadow(color: Colors.darkShadow, radius: 5, x: 0, y: 8)
                    .overlay(alignment: .bottomLeading) {
                        gameTitle
                    }
                    .overlay(alignment: .topLeading) {
                        gameIcon
                    }
                    .onAppear{
                        startAnimation()
                    }
            }.buttonStyle(GameButtonStyle())
        }
        
        var gameIconBig: some View {
            game.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: size.width / 2, maxHeight: size.width / 2)
                .foregroundColor(.white.opacity(0.1))
                .rotationEffect(Angle(degrees: isRotating ? 360.0 : 0.0))
                .scaleEffect(isPulsing ? 0.90 : 1)
                .animation(foreverAnimation, value: isRotating)
                .animation(pulseAnimation, value: isPulsing)
                .offset(x: size.width / 7.5, y: size.width / 9)
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
}
