import SwiftUI
import Foundation

struct MenuLabel: View {
    
    @EnvironmentObject var game: Game
    let type: OptionType
    
    enum OptionType {
        case restart
        case rules
        case tierFriendly(Bool)
        case tierChallenging(Bool)
        case tierNaughty(Bool)
        case edit
        
        var label: String {
            switch self {
            case .restart: return "Restart"
            case .rules: return "Rules"
            case .tierFriendly: return "Friendly"
            case .tierChallenging: return "Challenging"
            case .tierNaughty: return "Naughty"
            case .edit: return "Edit Components"
            }
        }
        
        var image: Image {
            switch self {
            case .restart: return Images.restart
            case .rules: return Images.rulesFill
            case .tierFriendly(let isSelected):
                if isSelected {
                    return Image(systemName: Images.Tiers.Friendly.selected)
                } else {
                    return Image(systemName: Images.Tiers.Friendly.unselected)
                }
            case .tierChallenging(let isSelected):
                if isSelected {
                    return Image(systemName: Images.Tiers.Challenging.selected)
                } else {
                    return Image(systemName: Images.Tiers.Challenging.unselected)
                }
            case .tierNaughty(let isSelected):
                if isSelected {
                    return Image(systemName: Images.Tiers.Naughty.selected)
                } else {
                    return Image(systemName: Images.Tiers.Naughty.unselected)
                }
            case .edit: return Images.edit
            }
            
        }
    }
    
    init(_ type: OptionType) {
        self.type = type
    }
    
    var body: some View {
        Text(type.label)
        type.image
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, game.game.gradient)
    }
}
