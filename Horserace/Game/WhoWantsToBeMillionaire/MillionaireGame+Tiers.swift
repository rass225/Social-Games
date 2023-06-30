import SwiftUI

extension MillionaireGame {
    @ViewBuilder
    func tiers() -> some View {
        HStack(alignment: .center, spacing: 0){
            Group{
                tierCell(position: .top, tier: .one, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .bottom, tier: .two, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .top, tier: .three, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .bottom, tier: .four, currentTier: $model.currentTier)
                Spacer()
            }
            Group{
                tierCell(position: .top, tier: .five, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .bottom, tier: .six, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .top, tier: .seven, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .bottom, tier: .eight, currentTier: $model.currentTier)
                Spacer()
            }
            Group{
                tierCell(position: .top, tier: .nine, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .bottom, tier: .ten, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .top, tier: .eleven, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .bottom, tier: .twelve, currentTier: $model.currentTier)
            }
            Group{
                Spacer()
                tierCell(position: .top, tier: .thirdteen, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .bottom, tier: .fourteen, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .top, tier: .fifthteen, currentTier: $model.currentTier)
                Spacer()
                tierCell(position: .bottom, tier: .sixteen, currentTier: $model.currentTier)
            }
        }
        .padding(.horizontal, 8)
    }
    
    struct ProgressBar: View {
        @Binding var value: Float
        let size: CGSize
        
        var body: some View {
            ZStack(alignment: .leading) {
                Rectangle().frame(width: size.width - 16 , height: size.height)
                    .opacity(0.5)
                    .foregroundColor(.gray)
                    .frame(height: 10)
                
                Rectangle().frame(width: min(CGFloat(self.value)*size.width, size.width - 16), height: size.height)
                    .foregroundStyle(LinearGradient(colors: [.green, Colors.green, .init(red: 0, green: 0.5, blue: 0)], startPoint: .leading, endPoint: .trailing))
                    .animation(.linear(duration: 1), value: value)
                    .frame(height: 10)
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
    
    struct tierCell: View {
        
        @EnvironmentObject var game: Game
        
        enum Position {
            case top
            case bottom
        }
        let position: Position
        let tier: MillionaireModel.Tier
        @Binding var currentTier: MillionaireModel.Tier
        var color: Color {
            if tier.hasBeenReached(currentTier) {
                if tier.level == currentTier.level {
                    return .green
                } else {
                    return Colors.text
                }
            } else {
                return .gray
            }
        }
        @State private var weight: Font.Weight = .semibold
        
        var body: some View {
            VStack(spacing: tier.isMilestoneTier ? 5 : 8){
                switch position {
                case .top:
                    Text(tier.valueString)
                        .font(.caption2.weight(weight))
                        .fixedSize()
                        .frame(alignment: .leading)
                        .foregroundColor(color)
                    circle
                    Text("X")
                        .font(.caption2.weight(weight))
                        .fixedSize()
                        .opacity(0)
                case .bottom:
                    Text("X")
                        .font(.caption2.weight(weight))
                        .fixedSize()
                        .opacity(0)
                    circle
                    Text(tier.valueString)
                        .font(.caption2.weight(weight))
                        .fixedSize()
                        .frame(alignment: .leading)
                        .foregroundColor(color)
                }
            }
            .fixedSize()
            .frame(width: 8)
        }
        
        var circle: some View {
            Circle()
                .frame(width: tier.circleSize, height: tier.circleSize)
                .foregroundColor(Colors.text)
        }
    }
}
