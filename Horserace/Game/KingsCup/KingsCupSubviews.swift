import Foundation
import SwiftUI

extension KingsCupGame {
    
    var gameOver: some View {
        VStack{
            GeometryReader { geometry in
                let size = geometry.size
                
                Text("Game over")
                    .foregroundColor(Colors.text)
                    .font(Fonts.largeTitle)
                    .offset(x: 0, y: size.height / 6)
                    .maxWidth()
                Text("\(players[currentPlayer]) lost. Drink the king's cup!")
                    .font(Fonts.title3)
                    .maxWidth()
                    .offset(x: 0, y: size.height / 2)
                VStack(spacing: 16){
                    Spacer()
                    Button(action: {
                        restartGame()
                        showGameOver.toggle()
                    }) {
                        MainButton(label: "Restart")
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: {
                        showGameOver.toggle()
                        appState.toMainMenu(withDelay: true)
                    }) {
                        MainButton(label: "Main Menu")
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding([.horizontal, .bottom])
        .background(Colors.background)
        .interactiveDismissDisabled(true)
    }
    
    struct CircleWaveView: View {
        
        @EnvironmentObject var game: Game
        @State private var waveOffset = Angle(degrees: 0)
        var percent: Double
        
        var body: some View {
            Wave(offset: Angle(degrees: waveOffset.degrees))
                .fill(LinearGradient(gradient: Gradient(colors: [game.game.background[0], game.game.color]), startPoint: .center, endPoint: .top))
                .offset(x: 0, y: 100 - (100 * percent))
                .animation(.easeOut(duration: 2), value: percent)
                .clipShape(CupShape())
                .overlay{
                    CupShape()
                        .stroke(game.game.gradient, style: StrokeStyle(lineWidth: 6, lineCap: .square, lineJoin: .round))
                        
                }
                
                .onAppear {
                    DispatchQueue.main.async {
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                            waveOffset = Angle(degrees: 360)
                        }
                    }
                }
                
        }
    }
    
    struct DescriptionView: View {
        @Binding var title: String
        @Binding var rule: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12){
                Text(title)
                    .foregroundColor(Colors.text)
                    .font(Fonts.title)
                Text(rule)
                    .font(.subheadline.weight(.regular))
                    .foregroundColor(Colors.grayText)
            }
            .maxWidth(alignment: .leading)
            .padding(.horizontal, 8)
            
        }
    }
}
