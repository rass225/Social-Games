import CoreMotion
import SwiftUI

struct ExplainGame: View {
    
    private enum GameState {
        case setup
        case play
    }
    @StateObject var motion = MotionManager()
    @State private var index = 0
    @State private var state: GameState = .setup
    @State var isRulesOpen = false
    var data: [String] = ["Koer", "Kass", "Hamster", "Banaan", "Õun", "Telekas"]
    
    
    var body: some View {
        VStack{
            switch state {
            case .setup:
                Button(action: {
                    state = .play
                }) {
                    VStack(spacing: 16){
                        Text("Press to Play")
                            .textCase(.uppercase)
                            .font(.largeTitle.weight(.semibold))
                        Text("Set the phone on your forehead, facing the players")
                            .lineLimit(1)
                            .font(.body.weight(.regular))
                            .foregroundColor(.gray)
                            .maxWidth()
                    }
                    .maxWidth()
                    .maxHeight()
                }
            case .play:
                Text(gameLogic())
                    .font(.largeTitle)
                    .foregroundColor(Colors.text)
                Text("\(motion.x)")
            }
        }
        .rotationEffect(.degrees(-90))
        .maxWidth()
        .maxHeight()
        .gameViewModifier(game: .explain)
        .navigationModifier(game: .explain)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                HomeButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesButton(isOpen: $isRulesOpen)
            }
            ToolbarItem(placement: .principal) {
                GameTitle()
            }
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
    }
    
    func gameLogic() -> String {
        if motion.x > 1.5 {
            return data[2]
        } else {
            return data[0]
        }
    }
}


class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    
    init() {
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let motion = data?.attitude else { return }
            self?.x = motion.roll
            self?.y = motion.pitch
        }
    }
}
