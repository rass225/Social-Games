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
            case .neverHaveIEver: SetupView()
            case .whosMostLikely: Text("Maintenance")
            case .kingsCup: SetupView()
            case .pyramid: SetupView()//SetupView(game: .pyramid)
            case .higherLower: SetupView()
            case .chooser:
                ChooserGame()
                    .background(
                        ZStack{
                            DefaultBackground()
                            GameIconBackground(game: gameObject.game)
                           
                                
                        }
                       
                    )
            case .explain:
                Text("Maintenance")
            case .roulette: SetupView()
            case .wheel: SetupView()
            }
        }
        .background(DefaultBackground())
        .environmentObject(gameObject)
    }
}
