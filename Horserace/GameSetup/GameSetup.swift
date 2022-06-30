import SwiftUI

struct GameSetup: View {
    
    @StateObject var gameObject: Game
    
    init(game: Games) {
        _gameObject = StateObject(wrappedValue: Game(game: game))
    }
    
    var body: some View {
        VStack{
            switch gameObject.game {
            case .horseRace: SetupView()
            case .truthDare: SetupView()
            case .spinBottle: SpinBottleGame()
            case .neverHaveIEver: NeverHaveIEverGame()
            case .whosMostLikely: WhosMostLikelyGame()
            case .pyramid: SetupView()//SetupView(game: .pyramid)
            case .higherLower: SetupView()
            case .chooser: ChooserGame()
            case .explain: ExplainGame()
            case .roulette: SetupView()
            case .wheel: SetupView()
            case .mancala: SetupView()
            }
        }
        .background(DefaultBackground())
        .environmentObject(gameObject)
        .onAppear{
            print("Game mode: \(gameObject.game.rawValue)")
        }
    }
}
