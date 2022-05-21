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
                Image(systemName: "diamond.fill")
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
                Divider().background(.ultraThickMaterial)
                BetView(bet: .secondQ, placedBet: $model.placedBet)
                Divider().background(.ultraThickMaterial)
                BetView(bet: .thirdQ, placedBet: $model.placedBet)
            }
            Divider().background(.ultraThickMaterial)
            HStack(spacing: 0){
                Group{
                    BetView(bet: .firstHalf, placedBet: $model.placedBet)
                    Divider().background(.ultraThickMaterial)
                    BetView(bet: .even, placedBet: $model.placedBet)
                    Divider().background(.ultraThickMaterial)
                    BetImageView(bet: .red, placedBet: $model.placedBet)
                }
                Group{
                    Divider().background(.ultraThickMaterial)
                    BetImageView(bet: .black, placedBet: $model.placedBet)
                    Divider().background(.ultraThickMaterial)
                    BetView(bet: .odd, placedBet: $model.placedBet)
                    Divider().background(.ultraThickMaterial)
                    BetView(bet: .secondHalf, placedBet: $model.placedBet)
                }
                
            }
        }
        .frame(height: 100)
        .background(LinearGradient(gradient: Gradient(colors: game.game.background), startPoint: .bottom, endPoint: .top))
        .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(lineWidth: 1)
                .fill(LinearGradient(gradient: Gradient(colors: game.game.background), startPoint: .bottom, endPoint: .top))
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
    
    var landingIndicator: some View {
        Image(systemName: "arrowtriangle.down.fill")
            .font(.title3.weight(.light))
            .foregroundColor(game.game.background[0])
            .opacity(model.status == .roulette ? 1 : 0)
    }
    
    var rouletteTable: some View {
        GeometryReader { geometry in
            let size = geometry.size
            VStack(spacing: 0){
                Spacer()
                landingIndicator
                Image("RouletteTable")
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
                        
//                            .opacity(model.isAnimating || model.placedBet != .none ? 0 : 1)
                    }
                Spacer()
            }
        }
        .padding(.horizontal, 24)
    }
}
