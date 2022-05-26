import SwiftUI

struct CardBack: View {
    
    let size: Size
    let geometry: CGSize
    
    var body: some View {
        VStack(spacing: padding()){
            HStack(spacing: padding()){
                Images.heart
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: width() / 4)
                    .foregroundColor(.red)
                    
                Images.spade
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: width() / 4)
                    .foregroundColor(.black)
            }
            HStack(spacing: padding()){
                Images.club
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: width() / 4)
                    .foregroundColor(.black)
                Images.diamond
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: width() / 4)
                    .foregroundColor(.red)
            }
        }
       
        .frame(width: width(), height: height())
        .background(
            LinearGradient(gradient: Gradient(colors: [.init(red: 0.8, green: 0.8, blue: 0.8), .white, .white]), startPoint: .bottom, endPoint: .top)
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
            
        )
    }
    
    func padding() -> CGFloat {
        switch size {
        case .small: return 2
        case .medium: return 4
        case .large: return 6
        }
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
    
    func suitFont() -> Font {
        switch size {
        case .small: return .caption
        case .medium: return .headline
        case .large: return .title
        }
    }
}

