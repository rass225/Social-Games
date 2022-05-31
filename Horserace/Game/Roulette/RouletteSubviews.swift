import SwiftUI

extension RouletteGame {
    
    struct BetView: View {
        @EnvironmentObject var game: Game
        let bet: RouletteModel.BetType
        @Binding var placedBet: RouletteModel.BetType
        
        var body: some View {
            Button(action: {
                placedBet = bet
            }) {
                Text(bet.rawValue)
                    .font(.subheadline.weight(.regular))
                    .foregroundColor(bet == placedBet ? Color.black : Color.white)
                    .maxWidth()
                    .frame(height: 50)
                    .background(bet == placedBet ? game.game.color : .clear)
            }
        }
    }
    
    struct BetImageView: View {
        @EnvironmentObject var game: Game
        let bet: RouletteModel.BetType
        @Binding var placedBet: RouletteModel.BetType
        
        var body: some View {
            Button(action: {
                placedBet = bet
            }) {
                Images.diamondFill
                    .foregroundColor(bet == .red ? .red : .black)
                    .font(.title)
                    .maxWidth()
                    .frame(height: 50)
                    .background(bet == placedBet ? game.game.color : .clear)
            }
        }
    }
    
    var betBoard: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                BetView(bet: .firstQ, placedBet: $model.placedBet)
                divider
                BetView(bet: .secondQ, placedBet: $model.placedBet)
                divider
                BetView(bet: .thirdQ, placedBet: $model.placedBet)
            }
            divider
            HStack(spacing: 0){
                Group{
                    BetView(bet: .firstHalf, placedBet: $model.placedBet)
                    divider
                    BetView(bet: .even, placedBet: $model.placedBet)
                    divider
                    BetImageView(bet: .red, placedBet: $model.placedBet)
                }
                Group{
                    divider
                    BetImageView(bet: .black, placedBet: $model.placedBet)
                    divider
                    BetView(bet: .odd, placedBet: $model.placedBet)
                    divider
                    BetView(bet: .secondHalf, placedBet: $model.placedBet)
                }
            }
        }
        .frame(height: 100)
        .background(game.game.gradient)
        .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(lineWidth: 1)
                .fill(game.game.gradient)
                .opacity(model.status == .notStarted ? 0 : 1)
                .opacity(model.status == .roulette ? 0.5 : 1)
        )
        .opacity(model.status == .notStarted ? 0 : 1)
        .opacity(model.status == .roulette ? 0.5 : 1)
        .animation(.linear(duration: 0.5), value: model.status)
        .disabled(model.isAnimating ? true : false)
        .disabled(model.status == .roulette ? true : false)
        .padding(.bottom)
        
    }
    var divider: some View {
        Divider().background(.ultraThickMaterial)
    }
    
    var landingIndicator: some View {
        Images.landingIndicator
            .font(.title3.weight(.light))
            .foregroundColor(scheme == .light ? game.game.background[0] : game.game.color)
            .opacity(model.status == .roulette ? 1 : 0)
    }
    
    var rouletteTable: some View {
        GeometryReader { geometry in
            let size = geometry.size
            VStack(spacing: 0){
                Spacer()
                landingIndicator
                Images.rouletteTable
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: model.spinDegrees))
                    .frame(maxWidth: size.height / 1.1, alignment: .top)
                    .animation(Animation.easeOut(duration: 5.0).repeatCount(1, autoreverses: false), value: model.spinDegrees)
                    .maxWidth()
                    .overlay(alignment: .topTrailing) {
                        if let sector = model.landingSector {
                            Text("\(sector.number)")
                                .font(Fonts.title)
                                .foregroundColor(.white)
                                .frame(width: 45, height: 45)
                                .background(Circle().foregroundColor(sector.color))
                                .opacity(model.isAnimating ? 0 : 1)
                        }
                    }
                    .opacity(model.placedBet == .none ? 0.3 : 1)
                    .animation(.linear(duration: 0.5), value: model.placedBet)
                    .overlay{
                        if !model.isAnimating && model.placedBet != .none && model.status == .roulette {
                            Text(model.title)
                                .font(.title3.weight(.regular))
                                .foregroundColor(Colors.text)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(.ultraThinMaterial)
                                .cornerRadius(8)
                        } else if model.placedBet == .none && !model.isAnimating {
                            Text(model.title)
                                .font(.title3.weight(.regular))
                                .foregroundColor(Colors.text)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(.ultraThinMaterial)
                                .cornerRadius(8)
                        }
                    }
                Spacer()
            }
        }
        .padding(.horizontal, 24)
    }
}
