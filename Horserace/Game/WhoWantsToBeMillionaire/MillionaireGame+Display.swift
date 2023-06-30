import SwiftUI

extension MillionaireGame {
    
    @ViewBuilder
    func display() -> some View {
        Image(systemName: "display")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .font(.largeTitle.weight(.ultraLight))
            .modifier(DisplayModifier(state: $model.gameState))
            .frame(maxWidth: .infinity)
        
            .onTapGesture {
                model.currentTier = .fifthteen
                model.updateProgress()
            }
            .overlay(alignment: .top, content: rewardLabel)
            .overlay{ GameStateLabel(state: $model.gameState) }
    }
    
    @ViewBuilder func rewardLabel() -> some View {
        VStack(spacing: 20){
            if model.gameState == .question {
                Text("For \(model.nextReward().valueString)")
                    .textCase(.uppercase)
                    .foregroundColor(Color.init(red: 0, green: 0.65, blue: 0))
                    .font(.callout.weight(.semibold))
                Text(model.currentQuestion.question)
                    .font(.title2.weight(.semibold))
            }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
    }
    
    struct GameStateLabel: View {
        
        @Binding var state: MillionaireModel.GameState
        @State var askCrowdTimeRemaining = 15
        @State var showTimer: Bool = false
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
 
        var body: some View {
            GeometryReader { geometry in
                let localFrame = geometry.frame(in: .local)
                let localSize = geometry.size
                let padding = localSize.height / 10
                
                
                VStack{
                    if state == .lifeline(.askCrowd) {
                        VStack{
                            if showTimer {
                                Text("\(askCrowdTimeRemaining)")
                                    .font(.system(size: 54).weight(.semibold))
                                    .onReceive(timer) { _ in
                                        if askCrowdTimeRemaining > 0 {
                                            askCrowdTimeRemaining -= 1
                                        }
                                    }
                            } else {
                                Image(systemName: state.image)
                                    .resizable()
                                    .font(.largeTitle.weight(.light))
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: localSize.height / 5, height: localSize.height / 5)
                                    .foregroundColor(.white)
                                Text(state.label)
                                    .font(.body.weight(.medium))
                                    .foregroundColor(.white)
                            }
                        }
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                showTimer.toggle()
                            }
                        }
                    } else {
                        if state != .question && state != .notStarted {
                            Image(systemName: state.image)
                                .resizable()
                                .font(.largeTitle.weight(.light))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: localSize.height / 5, height: localSize.height / 5)
                                .foregroundColor(.white)
                        }
                        Text(state.label)
                            .font(.body.weight(.medium))
                            .foregroundColor(.white)
                    }
                    
                }.position(x: localFrame.midX, y: localFrame.midY - padding)
            }
        }
    }
    
    struct DisplayModifier: ViewModifier {
        
        @Binding var state: MillionaireModel.GameState
        
        func body(content: Content) -> some View {
            switch state {
            case .question:
                content
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.gray)
            case .answerLocked:
                content
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.gray, Colors.orange)
            case .lifeline:
                content
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.gray, .blue)
            case .correctAnswer:
                content
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.gray, Colors.green)
            case .wrongAnswer:
                content
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.gray, Colors.red)
            case .moveUp:
                content
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.gray, Colors.green)
            case .gameover:
                content
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.gray)
            case .notStarted:
                content
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.gray)
            case .tryAgain:
                content
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.gray, Colors.red)
            }
        }
    }
}
