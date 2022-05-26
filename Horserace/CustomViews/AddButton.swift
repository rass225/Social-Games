import SwiftUI

struct AddButton: View {
    var body: some View {
        Images.add
            .resizable()
            .frame(width: 50, height: 50)
            .font(.body.weight(.light))
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, Colors.green)
    }
}
