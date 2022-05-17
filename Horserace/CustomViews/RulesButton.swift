import SwiftUI

struct RulesButton: View {
    
    @EnvironmentObject var game: Game
    @Binding var isRulesOpened: Bool
    
    var body: some View {
        Button(action: {
            isRulesOpened.toggle()
        }) {
            HStack{
//                Image(systemName: "text.book.closed.fill")
//                    .font(.footnote.weight(.light))
//                    .foregroundColor(Colors.mainColor)
                Text("Rules")
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(BlurEffect())
            .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
            .font(.body.weight(.regular))
            .foregroundColor(Colors.text)
        }
    }
}
