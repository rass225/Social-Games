import SwiftUI

struct CardBack: View {
    
    let size: Size
    let geometry: CGSize
    
    var body: some View {
        VStack(spacing: size.padding){
            HStack(spacing: size.padding){
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
            HStack(spacing: size.padding){
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
                .mask(RoundCorners(cornerRadius: size.cornerRadius))
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
            
        )
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
}

