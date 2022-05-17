import SwiftUI

struct MainButton: View {
    
    @EnvironmentObject var game: Game
    let label: String
    
    var body : some View {
        Text(label)
            .font(Fonts.title3)
            .foregroundColor(Colors.text)
            .maxWidth()
            .padding(.vertical)
            .modifier(MainButtonModifier())
    }
}
