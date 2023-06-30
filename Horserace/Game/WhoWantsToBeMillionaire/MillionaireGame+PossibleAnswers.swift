import SwiftUI

extension MillionaireGame {
    @ViewBuilder
    func possibleAnswersView() -> some View {
        VStack(spacing: 8){
            answerAbutton()
            answerBbutton()
            answerCbutton()
            answerDbutton()
        }
    }
    
    @ViewBuilder
    func answerAbutton() -> some View {
        Button(action: {
            model.determineOutcome(answer: .A)
        }) {
            PossibleAnswerCell(model: model, answerIndex: .A)
        }
        .disabled(model.gameState != .question)
        .disabled(model.isAnswerDisabledByFiftyFifty(answer: .A))
        .opacity(model.isAnswerDisabledByFiftyFifty(answer: .A) ? 0.3 : 1)
        .animation(.easeOut(duration: 0.5), value: model.isAnswerDisabledByFiftyFifty(answer: .A))
    }
    
    @ViewBuilder
    func answerBbutton() -> some View {
        Button(action: {
            model.determineOutcome(answer: .B)
        }) {
            PossibleAnswerCell(model: model, answerIndex: .B)
        }
        .disabled(model.gameState != .question)
        .disabled(model.isAnswerDisabledByFiftyFifty(answer: .B))
        .opacity(model.isAnswerDisabledByFiftyFifty(answer: .B) ? 0.3 : 1)
        .animation(.easeOut(duration: 0.5), value: model.isAnswerDisabledByFiftyFifty(answer: .B))
    }
    
    @ViewBuilder
    func answerCbutton() -> some View {
        Button(action: {
            model.determineOutcome(answer: .C)
        }) {
            PossibleAnswerCell(model: model, answerIndex: .C)
        }
        .disabled(model.gameState != .question)
        .disabled(model.isAnswerDisabledByFiftyFifty(answer: .C))
        .opacity(model.isAnswerDisabledByFiftyFifty(answer: .C) ? 0.3 : 1)
        .animation(.easeOut(duration: 0.5), value: model.isAnswerDisabledByFiftyFifty(answer: .C))
    }
    
    @ViewBuilder
    func answerDbutton() -> some View {
        Button(action: {
            model.determineOutcome(answer: .D)
        }) {
            PossibleAnswerCell(model: model, answerIndex: .D)
        }
        .disabled(model.gameState != .question)
        .disabled(model.isAnswerDisabledByFiftyFifty(answer: .D))
        .opacity(model.isAnswerDisabledByFiftyFifty(answer: .D) ? 0.3 : 1)
        .animation(.easeOut(duration: 0.5), value: model.isAnswerDisabledByFiftyFifty(answer: .D))
    }
    
    struct PossibleAnswerCell: View {
        
        @ObservedObject var model: MillionaireModel
        let answerIndex: MillionaireModel.PickedAnswer
        
        var body: some View {
            Text(displayLabel())
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal,8)
                .maxWidth()
                .modifier(CellBackground(model: model, answerIndex: answerIndex))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(alignment: .leading){
                    Text(answerIndex.rawValue)
                        .font(.callout.weight(.semibold))
                        .modifier(IndexForeground(model: model, answerIndex: answerIndex))
                        .padding(.leading, 12)
                }
                .opacity(model.gameState == .lifeline(.skipQuestion) ? 0 : 1)
        }
        
        func displayLabel() -> String {
            switch answerIndex {
            case .A: return model.currentQuestion.answer1
            case .B: return model.currentQuestion.answer2
            case .C: return model.currentQuestion.answer3
            case .D: return model.currentQuestion.answer4
            }
        }
        
        
    }
    
    private struct IndexForeground : ViewModifier {
        @EnvironmentObject var game: Game
        @ObservedObject var model: MillionaireModel
        let answerIndex: MillionaireModel.PickedAnswer
        
        func body(content: Content) -> some View {
            
            switch model.gameState {
            case .question:
                content
                    .foregroundColor(.gray)
            case .answerLocked:
                if model.pickedAnswer == answer() {
                    content
                        .foregroundColor(.white)
                } else {
                    content
                        .foregroundColor(.gray)
                        .opacity(0.7)
                }
            case .lifeline:
                content
                    .foregroundColor(.gray)
            case .correctAnswer:
                if model.pickedAnswer == answer() {
                    if model.currentQuestion.correctAnswer == model.pickedAnswer {
                        content
                            .foregroundColor(.white)
                    } else {
                        content
                            .foregroundColor(.gray)
                    }
                } else {
                    content
                        .foregroundColor(.gray)
                }
            case .wrongAnswer:
                if model.pickedAnswer == answer() {
                    if model.currentQuestion.correctAnswer != model.pickedAnswer {
                        content
                            .foregroundColor(.white)
                    } else {
                        content
                            .foregroundColor(.gray)
                    }
                } else {
                    content
                        .foregroundColor(.gray)
                }
            case .moveUp:
                content
            case .gameover:
                content
            case .notStarted:
                content
            case .tryAgain:
                content
            }
            
        }
        
        func answer() -> String {
            switch answerIndex {
            case .A: return model.currentQuestion.answer1
            case .B: return model.currentQuestion.answer2
            case .C: return model.currentQuestion.answer3
            case .D: return model.currentQuestion.answer4
            }
        }
    }
    
    private struct CellBackground : ViewModifier {
        
        @EnvironmentObject var game: Game
        @ObservedObject var model: MillionaireModel
        let answerIndex: MillionaireModel.PickedAnswer
        
        func body(content: Content) -> some View {
            
            switch model.gameState {
            case .question:
                content
                    .background(game.game.gradient)
            case .answerLocked:
                if model.pickedAnswer == answer() {
                    content
                        .background(Colors.orange)
                } else {
                    content
                        .background(game.game.gradient)
                        .opacity(0.7)
                }
            case .lifeline:
                content
                    .background(game.game.gradient)
            case .correctAnswer:
                if model.pickedAnswer == answer() {
                    if model.currentQuestion.correctAnswer == model.pickedAnswer {
                        content
                            .background(Colors.green)
                    } else {
                        content
                            .background(game.game.gradient)
                            .opacity(0.7)
                    }
                } else {
                    content
                        .background(game.game.gradient)
                        .opacity(0.7)
                }
            case .wrongAnswer:
                if model.pickedAnswer == answer() {
                    if model.currentQuestion.correctAnswer != model.pickedAnswer {
                        content
                            .background(Colors.red)
                    } else {
                        content
                            .background(game.game.gradient)
                    }
                } else {
                    if answer() == model.currentQuestion.correctAnswer {
                        content
                            .background(Colors.green)
                            .opacity(0.7)
                    } else {
                        content
                            .background(game.game.gradient)
                    }
                }
            case .moveUp:
                content
            case .gameover:
                content
            case .notStarted:
                content
                    .background(game.game.gradient)
            case .tryAgain:
                content
            }
        }
        
        func answer() -> String {
            switch answerIndex {
            case .A: return model.currentQuestion.answer1
            case .B: return model.currentQuestion.answer2
            case .C: return model.currentQuestion.answer3
            case .D: return model.currentQuestion.answer4
            }
        }
    }
}
