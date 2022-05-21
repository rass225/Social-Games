import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func navigationModifier(game: Games) -> some View {
        return self
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
    }
    
    func gameViewModifier(game: Games) -> some View {
        return self
            .padding(.horizontal, 20)
            .padding(.bottom)
            .padding(.top)
            .background(DefaultBackground())
    }
    
    func maxWidth(alignment: Alignment = .center) -> some View {
        return self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func maxHeight(alignment: Alignment = .center) -> some View {
        return self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func isGameDisabled(_ isDisabled: Binding<Bool>) -> some View {
        return self
            .opacity(0.2)
            .disabled(true)
            .onTapGesture {
                isDisabled.wrappedValue.toggle()
            }
    }
    
    func blurEffectStyle(_ style: UIBlurEffect.Style) -> some View {
        environment(\.blurEffectStyle, style)
    }
    
    func blurEffect() -> some View {
        ModifiedContent(content: self, modifier: BlurEffectModifier())
    }
}
