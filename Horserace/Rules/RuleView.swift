import SwiftUI

struct RuleView: View {
    
    @EnvironmentObject var game: Game
    @Binding var isOpen: Bool
    
    var body: some View {
        NavigationView{
            ScrollView {
                ruleContent
            }
            .background(Colors.background)
            .navigationBarTitle(game.game.title, displayMode: .inline)
            .navigationBarItems(trailing: Button("Done", action: closeView).buttonStyle(closeButtonStyle()))
        }
    }
    
    var ruleContent: some View {
        VStack(spacing: 32){
            switch game.game {
            case .horseRace:
                HorseRaceRules()
            case .truthDare:
                TruthOrDareRules()
            case .neverHaveIEver:
                NeverHaveIEverRules()
            case .pyramid:
                PyramidRules()
            case .spinBottle:
                SpinBottleRules()
            case .whosMostLikely:
                WhosMostLikelyRules()
            case .higherLower:
                HigherLowerRules()
            case .chooser:
                ChooserRules()
            case .explain:
                EmptyView()
            case .roulette:
                RouletteRules()
            case .wheel:
                WheelRules()
            case .mancala:
                Text("Mancala rules")
            case .trivia:
                TriviaRules()
            case .millionaire:
                Text("Millinaire")
            }
        }
        .padding(.horizontal)
        .padding(.leading, 8)
    }
    
    func closeView() {
        self.isOpen = false
    }
    
    struct closeButtonStyle: ButtonStyle {
        
        @EnvironmentObject var game: Game
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.body.weight(.semibold))
                .foregroundColor(game.game.background[1])
        }
    }
}
