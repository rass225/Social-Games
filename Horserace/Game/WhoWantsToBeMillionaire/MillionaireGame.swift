import SwiftUI

struct MillionaireGame: View {
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: MillionaireModel
    @State var isRulesOpen = false
    
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
                        HStack(alignment: .center, spacing: 0){
                            Group{
                                tierCell(position: .top, tier: .one, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .bottom, tier: .two, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .top, tier: .three, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .bottom, tier: .four, currentTier: $model.currentTier)
                                Spacer()
                            }
                            Group{
                                tierCell(position: .top, tier: .five, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .bottom, tier: .six, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .top, tier: .seven, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .bottom, tier: .eight, currentTier: $model.currentTier)
                                Spacer()
                            }
                            Group{
                                tierCell(position: .top, tier: .nine, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .bottom, tier: .ten, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .top, tier: .eleven, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .bottom, tier: .twelve, currentTier: $model.currentTier)
                            }
                            Group{
                                Spacer()
                                tierCell(position: .top, tier: .thirdteen, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .bottom, tier: .fourteen, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .top, tier: .fifthteen, currentTier: $model.currentTier)
                                Spacer()
                                tierCell(position: .bottom, tier: .sixteen, currentTier: $model.currentTier)
                            }
                        }
                    }.padding(.vertical)
                    
                    HStack(spacing: 0){
                        Button(action: {
                            model.handleLifeline(lifeline: .fiftyfifty)
                        }) {
                            LifelineCell(lifeline: "50/50")
                        }
                        .disabled(model.lifelines.fiftyfifty)
                        .opacity(model.lifelines.fiftyfifty ? 0.4 : 1)
                        Spacer()
                        Button(action: {
                            model.handleLifeline(lifeline: .skipQuestion)
                        }) {
                            LifelineCell(lifeline: "Skip Question")
                        }
                        .disabled(model.lifelines.skipQuestion)
                        .opacity(model.lifelines.skipQuestion ? 0.4 : 1)
                            
                        Spacer()
                        Button(action: {
                            model.handleLifeline(lifeline: .askCrowd)
                        }) {
                            LifelineCell(lifeline: "Ask Crowd")
                        }
                        .disabled(model.lifelines.askCrowd)
                        .opacity(model.lifelines.askCrowd ? 0.4 : 1)
                    }
                    
                    Spacer()
                    
                    display(size: size)
                    
                    Spacer()
                }
                .onAppear{
                    model.size = size
                }
            }
            VStack(spacing: 8){
                Button(action: {
                    model.determineOutcome(answer: .A)
                }) {
                    PossibleAnswerCell(model: model, answerIndex: .A)
                }
                .disabled(model.gameState != .question)
                .disabled(model.isAnswerDisabledByFiftyFifty(answer: .A))
                .opacity(model.isAnswerDisabledByFiftyFifty(answer: .A) ? 0 : 1)
                Button(action: {
                    model.determineOutcome(answer: .B)
                }) {
                    PossibleAnswerCell(model: model, answerIndex: .B)
                }
                .disabled(model.gameState != .question)
                .disabled(model.isAnswerDisabledByFiftyFifty(answer: .B))
                .opacity(model.isAnswerDisabledByFiftyFifty(answer: .B) ? 0 : 1)
                
                Button(action: {
                    model.determineOutcome(answer: .C)
                }) {
                    PossibleAnswerCell(model: model, answerIndex: .C)
                }
                .disabled(model.gameState != .question)
                .disabled(model.isAnswerDisabledByFiftyFifty(answer: .C))
                .opacity(model.isAnswerDisabledByFiftyFifty(answer: .C) ? 0 : 1)
                Button(action: {
                    model.determineOutcome(answer: .D)
                }) {
                    PossibleAnswerCell(model: model, answerIndex: .D)
                }
                .disabled(model.gameState != .question)
                .disabled(model.isAnswerDisabledByFiftyFifty(answer: .D))
                .opacity(model.isAnswerDisabledByFiftyFifty(answer: .D) ? 0 : 1)
                
            }
            .padding(.bottom)
        }
        .maxWidth()
        .maxHeight()
        .gameViewModifier(game: game.game)
        .navigationModifier(game: game.game)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                HomeButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    Section{
                        Button(action: {
                            isRulesOpen.toggle()
                        }) {
                            Text("Rules")
                            Images.rulesFill
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, game.game.gradient)
                        }
                    }
                    Section{
                        Button(action: {
                            model.restart()
                        }) {
                            Text("Restart")
                            Images.restart
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, game.game.gradient)
                                .font(.title)
                        }
                    }
                }, label: {
                    GameMenuButton()
                })
            }
            ToolbarItem(placement: .principal) {
                GameTitle()
            }
        }
    }
    
    @ViewBuilder
    func display(size: CGSize) -> some View {
        Image(systemName: "display")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .font(.largeTitle.weight(.ultraLight))
            .modifier(DisplayModifier(state: $model.gameState))
            .frame(width: size.width - 32)
            .onTapGesture {
                model.currentTier = .eleven
                model.updateProgress()
            }
            .overlay(alignment: .top, content: {
                QuestionLabel(model: model)
            })
            .overlay{
                GameStateLabel(state: $model.gameState)
            }
    }
    
    struct QuestionLabel: View {
        
        @ObservedObject var model: MillionaireModel
        
        var body: some View {
            VStack(spacing: 16){
                
                if model.gameState == .question {
                    Text("For \(model.currentTier.valueString)")
                        .textCase(.uppercase)
                        .foregroundColor(.gray)
                        .font(.callout.weight(.medium))
                    Text(model.currentQuestion.question)
                        .font(.title3.weight(.semibold))
                        
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
        }
    }

    struct GameStateLabel: View {
        
        @Binding var state: MillionaireModel.GameState
        
        
        var image: String {
            switch state {
            case .question: return "questionmark"
            case .answerLocked: return "lock.fill"
            case .lifeline: return "waveform.path.ecg.rectangle.fill"
            case .correctAnswer: return "checkmark.circle.fill"
            case .wrongAnswer: return "x.circle.fill"
            case .moveUp: return "arrow.up.circle.fill"
            case .gameover: return "dollarsign.circle.fill"
            }
        }
        var label: String {
            switch state {
            case .question: return ""
            case .answerLocked: return "You locked your answer"
            case .lifeline(let choice): return "\(choice)"
            case .moveUp: return "You have progressed to the next stage"
            case .gameover: return "Game over"
            case .correctAnswer: return "Correct Answer"
            case .wrongAnswer: return "Wrong Answer"
            }
        }
        
        
        var body: some View {
            GeometryReader { geometry in
                let localFrame = geometry.frame(in: .local)
                let localSize = geometry.size
                let padding = localSize.height / 10
                VStack{
                    if state != .question {
                        Image(systemName: image)
                            .resizable()
                            .font(.largeTitle.weight(.light))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: localSize.height / 5, height: localSize.height / 5)
                            .foregroundColor(.white)
                    }
                    
                
                    Text(label)
                        .font(.body.weight(.medium))
                        .foregroundColor(.white)
                }.position(x: localFrame.midX, y: localFrame.midY - padding)
            }
        }
    }
    
    struct tierCell: View {
        
        @EnvironmentObject var game: Game
        
        enum Position {
            case top
            case bottom
        }
        let position: Position
        let tier: MillionaireModel.Tier
        @Binding var currentTier: MillionaireModel.Tier
        var color: Color {
            if tier.hasBeenReached(currentTier) {
                if tier.level == currentTier.level {
                    return .green
                } else {
                    return Colors.text
                }
            } else {
                return .gray
            }
        }
        @State private var weight: Font.Weight = .medium
        
        private var circleSize: Double {
            switch isMilestoneTier() {
            case true: return 16
            case false: return 10
            }
        }
        
        var body: some View {
            VStack(spacing: isMilestoneTier() ? 5 : 8){
                switch position {
                case .top:
                    Text(tier.valueString)
                        .font(.footnote.weight(weight))
                        .fixedSize()
                        .frame(alignment: .leading)
                        .foregroundColor(color)
                    circle
                    Text("X")
                        .font(.footnote.weight(weight))
                        .fixedSize()
                        .opacity(0)
                case .bottom:
                    Text("X")
                        .font(.footnote.weight(weight))
                        .fixedSize()
                        .opacity(0)
                    circle
                    Text(tier.valueString)
                        .font(.footnote.weight(weight))
                        .fixedSize()
                        .frame(alignment: .leading)
                        .foregroundColor(color)
                }
            }
            .fixedSize()
            .frame(width: 8)
        }
        
        var circle: some View {
            Circle()
                .frame(width: circleSize, height: circleSize)
                .foregroundStyle(LinearGradient(colors: [game.game.color, Colors.text], startPoint: .bottom, endPoint: .top))
                
        }
        
        func isMilestoneTier() -> Bool {
            switch tier {
            case .one, .six, .eleven, .sixteen:
                return true
            default:
                return false
            }
        }
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
        }
        
        func displayLabel() -> String {
            switch answerIndex {
            case .A: return model.currentQuestion.answer1
            case .B: return model.currentQuestion.answer2
            case .C: return model.currentQuestion.answer3
            case .D: return model.currentQuestion.answer4
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
    
    struct LifelineCell: View {
        @EnvironmentObject var game: Game
        
        let lifeline: String
        
        var body: some View {
            Text(lifeline)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
                .maxWidth()
                .background(game.game.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .font(.footnote.weight(.semibold))
                .foregroundColor(.white)
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
            }
        }
    }
    
    struct ProgressBar: View {
        @EnvironmentObject var game: Game
        @Binding var value: Float
        let size: CGSize
        
        var body: some View {
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: size.width , height: size.height)
                        .opacity(0.5)
                        .foregroundColor(.gray)
                        .frame(height: 10)
                    
                    Rectangle().frame(width: min(CGFloat(self.value)*size.width, size.width), height: size.height)
                        .foregroundStyle(LinearGradient(colors: [.green, Colors.green, .init(red: 0, green: 0.5, blue: 0)], startPoint: .leading, endPoint: .trailing))
                        .animation(.linear(duration: 1), value: value)
                        .frame(height: 10)
                }
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}


