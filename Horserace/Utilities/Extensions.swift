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
            .padding()
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
            .opacity(0.5)
            .disabled(true)
            .onTapGesture {
                isDisabled.wrappedValue.toggle()
            }
    }
}

extension UIColor {
  convenience init(light: UIColor, dark: UIColor) {
    self.init { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .light, .unspecified:
        return light
      case .dark:
        return dark
      @unknown default:
        return light
      }
    }
  }
}

extension Color {
  init(light: Color, dark: Color) {
    self.init(UIColor(light: UIColor(light), dark: UIColor(dark)))
  }
}

extension UINavigationBar {
    static func changeAppearance(clear: Bool) {
        let appearance = UINavigationBarAppearance()
        
        if clear {
            appearance.configureWithTransparentBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
