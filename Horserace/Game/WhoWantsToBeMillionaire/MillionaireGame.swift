import SwiftUI

struct MillionaireGame: View {
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: MillionaireModel
    
    init(player: String) {
        model = MillionaireModel(player: player)
    }
    
    var body: some View {
        VStack{
            GeometryReader{ geo in
                let size = geo.size
                VStack{
                    ZStack(alignment: .center){
                        ProgressBar(value: $model.progress, size: size).frame(height: 9)
                        tiers()
                    }
                    .padding(.vertical)
                }
            }.frame(maxHeight: 100)
            display()
            Spacer()
            switch model.gameState {
            case .notStarted:
                startButton()
            case .tryAgain:
                tryAgainButton()
            case .gameover:
                newGameButton()
            default:
                lifelinesView()
                Spacer()
                possibleAnswersView()
            }
        }
        .maxWidth()
        .maxHeight()
        .gameViewModifier(game: game.game)
        .navigationModifier(game: game.game)
        .transition(.slide)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading, content: homeButton)
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    Section(content: rulesButton)
                    Section(content: restartButton)
                }, label: gameMenuButton)
            }
            ToolbarItem(placement: .principal, content: title)
        }
    }
}

// MARK: - View Components

private extension MillionaireGame {
    @ViewBuilder
    func title() -> some View {
        GameTitle()
    }
    
    @ViewBuilder
    func tryAgainButton() -> some View {
        Button(action: model.tryAgain) {
            Text("Try Again")
                .padding(.vertical, 16)
                .maxWidth()
                .background(game.game.gradient)
                .clipShape(Capsule(style: .continuous))
        }
    }
    
    @ViewBuilder
    func newGameButton() -> some View {
        Button(action: model.tryAgain) {
            Text("New Game")
                .padding(.vertical, 16)
                .maxWidth()
                .background(game.game.gradient)
                .clipShape(Capsule(style: .continuous))
        }
    }
    
    @ViewBuilder
    func startButton() -> some View {
        Button(action: {
            model.gameState = .question
        }) {
            Text("Start")
                .padding(.vertical, 16)
                .maxWidth()
                .background(game.game.gradient)
                .clipShape(Capsule(style: .continuous))
        }
    }
    
    
    
    @ViewBuilder
    func rulesButton() -> some View {
        Button(action: model.showRules) {
            MenuLabel(.rules)
        }
    }
    
    @ViewBuilder
    func restartButton() -> some View {
        Button(action: model.restart) {
            MenuLabel(.restart)
        }
    }
    
    @ViewBuilder
    func gameMenuButton() -> some View {
        GameMenuButton()
    }
    
    @ViewBuilder
    func homeButton() -> some View {
        HomeButton()
    }
}
