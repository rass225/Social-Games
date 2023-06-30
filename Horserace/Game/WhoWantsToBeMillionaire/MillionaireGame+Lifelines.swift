import SwiftUI

extension MillionaireGame {
    @ViewBuilder
    func lifelinesView() -> some View {
        HStack(spacing: 0){
            Spacer()
            fiftyFiftyButton()
            Spacer()
            skipQuestionButton()
            Spacer()
            askCrowdButton()
            Spacer()
        }
    }
    
    @ViewBuilder
    func fiftyFiftyButton() -> some View {
        Button(action: {
            model.handleLifeline(lifeline: .fiftyfifty)
        }, label: {
            Text("50/50")
                .font(.caption2.weight(.semibold))
                .frame(width: 44, height: 44)
                .background(game.game.gradient)
                .clipShape(Circle())
                .foregroundColor(.white)
        })
        .disabled(model.gameState != .question)
        .disabled(model.lifelines.fiftyfifty)
        .opacity(model.lifelines.fiftyfifty ? 0.3 : 1)
        .buttonStyle(.plain)
        .animation(.easeOut(duration: 0.25), value: model.lifelines.fiftyfifty)
    }
    
    @ViewBuilder
    func skipQuestionButton() -> some View {
        Button(action: {
            model.handleLifeline(lifeline: .skipQuestion)
        }, label: {
            Circle()
                .frame(width: 44, height: 44)
                .foregroundStyle(game.game.gradient)
                .overlay(alignment: .center) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.white)
                }
        })
        .disabled(model.gameState != .question)
        .disabled(model.lifelines.skipQuestion)
        .opacity(model.lifelines.skipQuestion ? 0.3 : 1)
        .buttonStyle(.plain)
        .animation(.easeOut(duration: 0.25), value: model.lifelines.skipQuestion)
    }
    
    @ViewBuilder
    func askCrowdButton() -> some View {
        Button(action: {
            model.handleLifeline(lifeline: .askCrowd)
        }, label: {
            Circle()
                .frame(width: 44, height: 44)
                .foregroundStyle(game.game.gradient)
                .overlay(alignment: .center) {
                    Image(systemName: "person.2.wave.2.fill")
                        .font(.footnote.weight(.regular))
                        .foregroundColor(.white)
                        .offset(x: -4, y: 0)
                }
        })
        .disabled(model.gameState != .question)
        .disabled(model.lifelines.askCrowd)
        .opacity(model.lifelines.askCrowd ? 0.3 : 1)
        .buttonStyle(.plain)
        .animation(.easeOut(duration: 0.25), value: model.lifelines.askCrowd)
    }
}
