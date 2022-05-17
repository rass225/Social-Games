import Foundation
import SwiftUI

extension HorceRaceGame {
    
    struct Finishline: View {
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
                }.cornerRadius(8)
                Spacer()
            }
        }
        
        var finishline1: some View {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.black)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.white)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.black)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.white)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.black)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.white)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.black)
            }
        }
        
        var finishline2: some View {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.white)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.black)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.white)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.black)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.white)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.black)
                Rectangle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.white)
            }
        }
    }
    
   
    
    var playersBoard: some View {
        VStack(alignment: .center, spacing: 0){
            LazyVGrid(columns: columns, alignment: .trailing, spacing: 0) {
                ForEach(model.players, id: \.self) { item in
                    HStack(spacing: 4){
                        switch item.suit {
                        case .clubs:
                            Images.club.foregroundColor(.black)
                        case .spades:
                            Images.spade.foregroundColor(.black)
                        case .heart:
                            Images.heart.foregroundColor(.red)
                        case .diamond:
                            Images.diamond.foregroundColor(.red)
                        case .none:
                            EmptyView()
                        }
                        Text(item.name)
                            .font(.subheadline.weight(.light))
                    }.padding(.vertical, 8)
                }
            }
            
        }
        .padding(8)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.vertical, 8)
    }
    
    var gameOver: some View {
        VStack{
            GeometryReader { geometry in
                let size = geometry.size
                
                Text("Game Over")
                    .foregroundColor(.blue)
                    .font(Fonts.largeTitle)
                    .offset(x: 0, y: size.height / 6)
                    .frame(maxWidth: .infinity, alignment: .center)
                VStack{
                    
                    switch model.winnerSuit {
                    case .heart:
                        Images.heart
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                            .foregroundColor(.red)
                    case .diamond:
                        Images.diamond
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                            .foregroundColor(.red)
                    case .spades:
                        Images.spade
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                            .foregroundColor(.black)
                    case .clubs:
                        Images.club
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                            .foregroundColor(.black)
                    default:
                        EmptyView()
                    }
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
                    
                    .frame(maxWidth: .infinity, alignment: .center)
                    .offset(x: 0, y: size.height / 2)
                } else {
                    VStack(spacing: 16){
                        Text("No winners this game")
                            .font(Fonts.title)
                    }
                    
                    .frame(maxWidth: .infinity, alignment: .center)
                    .offset(x: 0, y: size.height / 2)
                }
                
                VStack(spacing: 16){
                    Spacer()
                    Button(action: {
                        model.restart()
                    }) {
                        MainButton(label: "Restart")
                            .overlay(
                                RoundedRectangle(cornerRadius: 16).stroke(Colors.mainColor, lineWidth: 1)
                            )
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: {
                        model.isThereAWinner.toggle()
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
}
