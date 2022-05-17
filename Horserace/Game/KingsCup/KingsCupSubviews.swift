import Foundation
import SwiftUI

extension KingsCupGame {
    
    var gameOver: some View {
        VStack{
            GeometryReader { geometry in
                let size = geometry.size
                
                Text("Game over")
                    .foregroundColor(.teal)
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
                            .overlay(
                                RoundedRectangle(cornerRadius: 16).stroke(Colors.mainColor, lineWidth: 1)
                            )
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: {
                        showGameOver.toggle()
                        appState.toMainMenu(withDelay: true)
                    }) {
                        MainButton(label: "Main Menu")
                            .overlay(
                                RoundedRectangle(cornerRadius: 16).stroke(Colors.mainColor, lineWidth: 1)
                            )
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding([.horizontal, .bottom])
        .background(Colors.background)
        .interactiveDismissDisabled(true)
    }
    
    struct CircleWaveView: View {
        
        @State private var waveOffset = Angle(degrees: 0)
        var percent: Double
        
        var body: some View {
            Wave(offset: Angle(degrees: waveOffset.degrees))
                .fill(.thickMaterial)
                .offset(x: 0, y: 100 - (100 * percent))
                .animation(.easeOut(duration: 2), value: percent)
                .overlay{
                    CupShape()
                        .stroke(.thickMaterial, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        
                }
                .clipShape(CupShape())
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
                    .foregroundColor(Colors.reverseText)
                    .font(Fonts.title)
                Text(rule)
                    .font(.subheadline.weight(.regular))
            }
            .maxWidth(alignment: .leading)
            .padding(.horizontal, 8)
            
        }
    }
}
