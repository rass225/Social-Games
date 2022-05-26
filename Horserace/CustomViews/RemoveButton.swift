import SwiftUI

struct RemoveButton: View {
    var body: some View {
        Images.remove
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, Colors.red)
            .font(.title2)
            .padding(8)
    }
}
