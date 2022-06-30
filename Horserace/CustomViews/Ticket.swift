import SwiftUI

struct Ticket: View {
    
    @EnvironmentObject var game: Game
    let desiredWidth: Double
    @Binding var title: String
    @Binding var subtitle: String
    let footnote: String
    
    private let ticketColors = [Colors.ticketColor, Color.init(light: .init(red: 0.95, green: 0.95, blue: 0.95), dark: .init(red: 0.2, green: 0.2, blue: 0.2))]
    
    var body: some View {
        VStack{
            VStack(spacing: 16){
                Text(title)
                    .textCase(.uppercase)
                    .font(.title3.weight(.semibold))
                    .padding(.top, 32)
                    .foregroundColor(Colors.text)
                Text(subtitle)
                    .font(.title3.weight(.medium))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                Spacer()
                Text(footnote)
                    .textCase(.uppercase)
                    .font(.caption.weight(.semibold))
                    .foregroundColor(game.game.background[1])
                    .padding(.bottom, 8)
            }
            .padding(.top)
            .padding(.horizontal, 8)
            .frame(height: desiredWidth * 1.5)
            .frame(width: desiredWidth)
            .background(LinearGradient(gradient: Gradient(colors: ticketColors), startPoint: .top, endPoint: .bottom))
            .background(Colors.ticketColor)
            .clipShape(TicketShape())
            .shadow(color: Colors.darkShadow, radius: 6, x: 0, y: 0)
        }
        .maxWidth()
        .maxHeight()
    }
    
    struct TicketShape: Shape {
        func path(in rect: CGRect) -> Path {
            let arcRadius: CGFloat = 20
            let smallArcRadius:CGFloat = 15
            var path = Path()
            path.move(to: CGPoint(x: rect.origin.x, y: rect.origin.y + arcRadius))
            path.addArc(center: CGPoint.zero, radius: arcRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0) , clockwise: true)
            path.addArc(center: CGPoint(x: rect.midX, y: rect.origin.y) , radius: arcRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0) , clockwise: true)
            path.addLine(to:  CGPoint(x: rect.size.width - arcRadius, y: rect.origin.y))
            path.addArc(center: CGPoint(x: rect.size.width , y: rect.origin.y), radius: arcRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 90) , clockwise: true)
            path.addLine(to:  CGPoint(x: rect.size.width, y: rect.size.height - smallArcRadius))
            path.addArc(center: CGPoint(x: rect.size.width , y: rect.size.height), radius: smallArcRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 180) , clockwise: true)
            path.addLine(to:  CGPoint(x: rect.origin.x + smallArcRadius, y: rect.size.height))
            path.addArc(center: CGPoint(x: rect.origin.x , y: rect.size.height), radius: smallArcRadius, startAngle: Angle(degrees: 360), endAngle: Angle(degrees: 270) , clockwise: true)
            path.closeSubpath()
            return path
        }
    }
}
