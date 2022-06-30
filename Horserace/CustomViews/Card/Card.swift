import SwiftUI

struct Card: View {
    
    let suit: Suit
    let rank: Rank
    let size: Size
    let geometry: CGSize
    
    var body: some View {
        suit.image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: height() / 3)
            .foregroundColor(suit.color)
        .frame(width: width(), height: height())
        .overlay(alignment: .topLeading) {
            Text(rank.rawValue)
                .font(rankFont())
                .padding(.top, padding())
                .padding(.leading, padding())
                .foregroundColor(.black)
        }
        .overlay(alignment: .bottomTrailing) {
            Text(rank.rawValue)
                .font(rankFont())
                .padding(.top, padding())
                .padding(.leading, padding())
                .foregroundColor(.black)
                .rotationEffect(Angle(degrees: 180))
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.init(red: 0.85, green: 0.85, blue: 0.85), .white, .white]), startPoint: .bottom, endPoint: .top)
                .cornerRadius(cornerRadius())
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
        )
    }
    
    func cornerRadius() -> CGFloat {
        switch size {
        case .small: return 4
        case .medium: return 7
        case .large: return 10
        case .extraLarge: return 13
        }
    }
    
    func width() -> CGFloat {
        switch size {
        case .small: return geometry.height / 15
        case .medium: return geometry.height / 10
        case .large: return geometry.height / 6.6666
        case .extraLarge: return geometry.height / 4.5
        }
    }
    
    func height() -> CGFloat {
        switch size {
        case .small: return geometry.height / 10
        case .medium: return geometry.height / 6.6666666
        case .large: return geometry.height / 4.4444
        case .extraLarge: return geometry.height / 3
        }
    }
    
    func suitImage() -> AnyView {
        switch suit {
        case .heart: return AnyView(Images.heart.resizable())
        case .diamond: return AnyView(Images.diamond.resizable())
        case .spades: return AnyView(Images.spade.resizable())
        case .clubs: return AnyView(Images.club.resizable())
        }
    }
    
    func rankFont() -> Font {
        return Font.system(size: height() / 5.5)
    }
    
    func padding() -> CGFloat {
        switch size {
        case .small: return 2
        case .medium: return 4
        case .large: return 6
        case .extraLarge: return 8
        }
    }
}
