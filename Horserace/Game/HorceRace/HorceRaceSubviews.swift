import Foundation
import SwiftUI

extension HorceRaceGame {
    
    struct Finishline: View {
        @EnvironmentObject var game: Game
        let size: CGSize
        var body: some View {
            VStack{
                HStack(spacing: 0){
                    ForEach(0..<Int(size.width) / 5, id: \.self) { item in
                        if item.isMultiple(of: 2) {
                            finishline1
                        } else {
                            finishline2
                        }
                    }
//                    Spacer()
                }.cornerRadius(4)
                Spacer()
            }
        }
        
        var finishline1: some View {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(game.game.gradient)
                    .frame(width: 5, height: 5)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.clear)
                Rectangle()
                    .fill(game.game.gradient)
                    .frame(width: 5, height: 5)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.clear)
                Rectangle()
                    .fill(game.game.gradient)
                    .frame(width: 5, height: 5)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.clear)
                Rectangle()
                    .fill(game.game.gradient)
                    .frame(width: 5, height: 5)
            }
        }
        
        var finishline2: some View {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.clear)
                Rectangle()
                    .fill(game.game.gradient)
                    .frame(width: 5, height: 5)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.clear)
                Rectangle()
                    .fill(game.game.gradient)
                    .frame(width: 5, height: 5)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.clear)
                Rectangle()
                    .fill(game.game.gradient)
                    .frame(width: 5, height: 5)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.clear)
            }
        }
    }
    
   
    
    var playersBoard: some View {
        VStack(alignment: .center, spacing: 0){
            LazyVGrid(columns: columns, alignment: .trailing, spacing: 0) {
                ForEach(model.players, id: \.self) { item in
                    HStack(spacing: 4){
                        item.suit?.image
                            .foregroundColor(item.suit?.color)
                        Text(item.name)
                            .font(.subheadline.weight(.light))
                    }.padding(.vertical, 8)
                }
            }
        }
        .padding(8)
        .background(.thickMaterial)
        .mask(RoundCorners())
        .padding(.vertical, 8)
    }
    
    var gameOver: some View {
        VStack{
            GeometryReader { geometry in
                let size = geometry.size
                
                Text("Game Over")
                    .foregroundColor(Colors.text)
                    .font(Fonts.largeTitle)
                    .offset(x: 0, y: size.height / 6)
                    .maxWidth()
                VStack{
                    model.winnerSuit?.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75)
                        .foregroundColor(model.winnerSuit?.color)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .offset(x: 0, y: size.height / 4)
                if model.isThereWinner() {
                    VStack(spacing: 16){
                        Text("The winners are:")
                            .font(Fonts.title)
                        HStack(spacing: 16){
                            ForEach(model.players, id: \.self) { item in
                                if item.suit == model.winnerSuit {
                                    Text(item.name)
                                        .font(Fonts.title3)
                                }
                            }
                        }
                    }
                    .maxWidth()
                    .offset(x: 0, y: size.height / 2)
                } else {
                    VStack(spacing: 16){
                        Text("No winners this game")
                            .font(Fonts.title)
                    }
                    .maxWidth()
                    .offset(x: 0, y: size.height / 2)
                }
                
                VStack(spacing: 16){
                    Spacer()
                    Button(action: {
                        model.restart()
                    }) {
                        MainButton(label: "Restart")
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: {
                        model.isThereAWinner.toggle()
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
}
