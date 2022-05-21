import SwiftUI

struct DefaultBackground: View {

    var body: some View {
        ZStack{
            Gradients.backgroundBottomLayer
                .ignoresSafeArea()
            Gradients.backgroundTopLayer
                .ignoresSafeArea()
        }
    }
}

