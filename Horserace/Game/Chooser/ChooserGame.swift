import SwiftUI
import UIKit

struct ChooserGame: View {
    @EnvironmentObject var game: Game
    @State var isRulesOpen = false
    @State var points: [UITouch:CGPoint] = [:]
    @State var touchColors: Gradient = Gradients.chooserCircle
    @State var state: GameState = .idle
    @State var hasWinner = false
    
    public enum GameState {
        case idle
        case choosing
        case winner
    }

    var body: some View {
        ZStack {
            if points.isEmpty {
                Text("Touch the screen")
                    .font(.title3.weight(.regular))
                    .foregroundColor(Colors.text)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
            }
            
            TapView { touch, isWinner in
                points = touch
                hasWinner = isWinner
            }
            
            GeometryReader { geo in
                let size = geo.size
                let values = points.map {$0.value}
                ForEach(values.indices, id: \.self) { index in
                    TouchMarker(size: size)
                        .position(x: values[index].x, y: values[index].y)
                }
            }
        }
        .maxWidth()
        .maxHeight()
        .gameViewModifier(game: game.game)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(!points.isEmpty)
        .ignoresSafeArea()
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
                    .isHidden(points.isEmpty)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesButton(isOpen: $isRulesOpen)
                    .isHidden(points.isEmpty)
            }
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
    }
    
    private struct TouchMarker: View {
        @EnvironmentObject var game: Game
        let size: CGSize
        private let innerPulseAnimation: Animation = Animation.easeInOut(duration: 0.75).repeatForever(autoreverses: true)
        private let outerPulseAnimation: Animation = Animation.easeInOut(duration: 0.75).repeatForever(autoreverses: true)
    
        @State var isInnerPulsing: Bool = false
        @State var isOuterPulsing: Bool = false
        
        
        var body: some View {
            Circle()
                .strokeBorder(game.game.color.opacity(0.5), lineWidth: 7.5)
                .background(Circle().fill(game.game.gradient))
                .frame(width: size.width / 2.7, height: size.width / 2.7, alignment: .center)
                .scaleEffect(isOuterPulsing ? 1 : 1.1)
                .animation(outerPulseAnimation, value: isOuterPulsing)
                .overlay{
                    Circle()
                        .fill(game.game.color)
                        .frame(width: size.width / 4, height: size.width / 4, alignment: .center)
                        .blur(radius: 15)
                        .scaleEffect(isInnerPulsing ? 0.7 : 1)
                        .animation(innerPulseAnimation, value: isInnerPulsing)
                        .onAppear(perform: startPulsing)
                }
        }
        
        func startPulsing() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                isOuterPulsing = true
                isInnerPulsing = true
            }
        }
    }
}
