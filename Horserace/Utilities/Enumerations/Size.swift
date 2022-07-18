import Foundation
import SwiftUI

enum Size {
    case small
    case medium
    case large
    case extraLarge
    
    var font: Font {
        switch self {
        case .small: return .caption
        case .medium: return .headline
        case .large: return .title
        case .extraLarge: return .largeTitle
        }
    }
    
    var padding: CGFloat {
        switch self {
        case .small: return 2
        case .medium: return 4
        case .large: return 6
        case .extraLarge: return 8
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .small: return 4
        case .medium: return 7
        case .large: return 10
        case .extraLarge: return 13
        }
    }
}
