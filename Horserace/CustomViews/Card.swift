import SwiftUI

struct Card: View {
    
    let suit: Suit
    let rank: Rank
    let size: Size
    let geometry: CGSize
    
    var body: some View {
        suitImage()
           
//        .font(suitFont())
            .aspectRatio(contentMode: .fit)
            .frame(height: height() / 3)
        .foregroundColor(suitColor())
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
            Color.white
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
            
        )
    }
    
    func width() -> CGFloat {
        switch size {
        case .small: return geometry.height / 15
        case .medium: return geometry.height / 10
        case .large: return geometry.height / 6.6666
        }
    }
    
    func height() -> CGFloat {
        switch size {
        case .small: return geometry.height / 10
        case .medium: return geometry.height / 6.6666666
        case .large: return geometry.height / 4.4444
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
    
    func suitColor() -> Color {
        switch suit {
        case .heart: return .red
        case .diamond: return .red
        case .spades: return .black
        case .clubs: return .black
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
        }
    }
}
