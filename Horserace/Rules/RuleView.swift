import SwiftUI

struct RuleView: View {
    
    @EnvironmentObject var game: Game
    @Binding var isOpen: Bool
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ScrollView {
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
                        }
                    }
                    .padding(.horizontal)
                    .padding(.leading, 8)
                }
            }
            .background(Colors.background)
            .navigationBarTitle(game.game.title, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.isOpen = false
            }) {
                Text("Done")
                    .font(.body.weight(.semibold))
                    .foregroundColor(game.game.background[1])
            })
        }
    }
}
