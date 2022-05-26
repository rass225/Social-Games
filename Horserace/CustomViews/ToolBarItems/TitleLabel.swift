import SwiftUI

struct TitleLabel: View {
    
    @EnvironmentObject var game: Game
    let label: String
    var font: Font = Font.title.weight(.regular)
    var body: some View {
        Text(label)
            .font(font)
            .foregroundColor(Colors.reverseText)
    }
}
