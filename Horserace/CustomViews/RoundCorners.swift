import SwiftUI

struct RoundCorners: View {
    @State var cornerRadius: Double = 16
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }
}
