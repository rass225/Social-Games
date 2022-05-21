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
                            NewGameView(.kingsCup, size: size, willPulse: true)
                            NewGameView(.horseRace, size: size, willPulse: true)
                            NewGameView(.pyramid, size: size, willPulse: true)
                            NewGameView(.higherLower, size: size)
                                .isGameDisabled($showingAlert)
                        }
                        .padding(.horizontal, spacing)
                        .padding(.bottom, spacing)
                        
                    }
                }.padding(.top, spacing)
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
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Other Games")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: spacing){
                            NewGameView(.chooser, size: size, willPulse: true)
                        }
                        .padding(.horizontal, spacing)
                        .padding(.bottom, spacing)
                    }
                }
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Social Games")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: spacing){
                            NewGameView(.truthDare, size: size)
                                .isGameDisabled($showingAlert)
                            NewGameView(.neverHaveIEver, size: size)
                                .isGameDisabled($showingAlert)
                            NewGameView(.whosMostLikely, size: size)
                                .isGameDisabled($showingAlert)
                            NewGameView(.explain, size: size, willPulse: true)
                                .isGameDisabled($showingAlert)
                        }
                        .padding(.horizontal, spacing)
                        .padding(.bottom, spacing)
                        
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Coming Soon"), message: Text(alertMessage), dismissButton: .default(Text("Done")))
        }
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
            Animation.linear(duration: 3).repeatForever(autoreverses: true)
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
                ZStack(alignment: .trailing){
                    game.icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: size.width / 2)
                        .frame(maxHeight: size.width / 2)
                        .foregroundColor(.white.opacity(0.1))
                        
                        .rotationEffect(tilt)
                        .rotationEffect(Angle(degrees: isRotating ? 360.0 : 0.0))
                        .scaleEffect(isPulsing ? 0.90 : 1)
                        .animation(foreverAnimation, value: isRotating)
                        .animation(pulseAnimation, value: isPulsing)
                        .offset(x: size.width / 8, y: size.width / 9)
                    
                        
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
                        
                }
                .maxHeight()
                .frame(idealWidth: size.width / 1.75, maxWidth: size.width / 1.75)
                .frame(idealHeight: size.width / 2.2, maxHeight: size.width / 2.2)
                .overlay(alignment: .bottomLeading) {
                        Text(game.rawValue)
                            .font(.title2.weight(.semibold))
                            .foregroundColor(Color.white)
                            .tracking(0.5)
                            .padding(.vertical, 24)
                            .padding(.horizontal)
                            .maxWidth(alignment: .leading)
                }
                .overlay(alignment: .topLeading) {
                    game.icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: size.width / 12)
                        .frame(maxHeight: size.width / 12)
                        .foregroundColor(game.color)
                        .rotationEffect(tilt)
                        .scaleEffect(isPulsing ? 0.92 : 1)
                        .animation(pulseAnimation, value: isPulsing)
                        .padding(16)
                        .overlay{
                            if hasQuestionMark {
                                Image(systemName: "questionmark")
                                    .font(.body.weight(.bold))
                                    .foregroundColor(.white)
                                    
                            }
                        }
                        .padding(.bottom, 24)
                }
                .background(
                    ZStack{
                        game.gradient
//                        LinearGradient(gradient: Gradient(colors: [.black.opacity(0.9), .black.opacity(0.0)]), startPoint: .bottom, endPoint: .top)
                        LinearGradient(stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .clear, location: 0.4),
                            .init(color: .black.opacity(0.8), location: 1)
                        ], startPoint: .top, endPoint: .bottom)
                    }
                )
                .mask(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
                .shadow(color: Colors.darkShadow, radius: 5, x: 0, y: 8)
            }.buttonStyle(GameButtonStyle())
        }
    }
}
