import Foundation
import SwiftUI

class MillionaireModel: ObservableObject {
    
    enum Tier {
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        case eleven
        case twelve
        case thirdteen
        case fourteen
        case fifthteen
        case sixteen
        
        var percent: Float {
            let percent: Float = 1 / 15.75
            switch self {
            case .one: return 0.0
            case .two: return percent
            case .three: return percent * 2
            case .four: return percent * 3
            case .five: return percent * 4
            case .six: return percent * 5
            case .seven: return percent * 6
            case .eight: return percent * 7
            case .nine: return percent * 8
            case .ten: return percent * 9
            case .eleven: return percent * 10
            case .twelve: return percent * 11
            case .thirdteen: return percent * 12
            case .fourteen: return percent * 13
            case .fifthteen: return percent * 14
            case .sixteen: return percent * 15
            }
        }
        
        var valueString: String {
            switch self {
            case .one: return "$0"
            case .two: return "$100"
            case .three: return "$200"
            case .four: return "$300"
            case .five: return "$500"
            case .six: return "$1K"
            case .seven: return "$2K"
            case .eight: return "$4K"
            case .nine: return "$8K"
            case .ten: return "$16K"
            case .eleven: return "$32K"
            case .twelve: return "$64K"
            case .thirdteen: return "$125K"
            case .fourteen: return "$250K"
            case .fifthteen: return "$500K"
            case .sixteen: return "$1M"
            }
        }
        
        var level: Int {
            switch self {
            case .one: return 1
            case .two: return 2
            case .three: return 3
            case .four: return 4
            case .five: return 5
            case .six: return 6
            case .seven: return 7
            case .eight: return 8
            case .nine: return 9
            case .ten: return 10
            case .eleven: return 11
            case .twelve: return 12
            case .thirdteen: return 13
            case .fourteen: return 14
            case .fifthteen: return 15
            case .sixteen: return 16
            }
        }
        
        func hasBeenReached(_ currentTier: Tier) -> Bool {
            switch self.level > currentTier.level {
            case true:
                return false
            case false:
                return true
            }
        }
    }
    
    enum GameState: Equatable {
        case question
        case answerLocked
        case lifeline(Lifeline)
        case correctAnswer
        case wrongAnswer
        case moveUp
        case gameover
    }
    
    enum Lifeline {
        case fiftyfifty
        case skipQuestion
        case askCrowd
        
        var label: String {
            switch self {
            case .fiftyfifty: return "50/50"
            case .skipQuestion: return "Skip Question"
            case .askCrowd: return "Ask Crowd"
            }
        }
    }
    
    enum PickedAnswer: String, CaseIterable {
        case A
        case B
        case C
        case D
    }
    
    @Published var progress: Float = 0.0
    @Published var isRulesOpen = false
    @Published var currentTier: Tier = .one
    @Published var gameState: GameState = .question
    @Published var pickedAnswer: String = ""
    @Published var lifelines = Lifelines(
        fiftyfifty: false,
        skipQuestion: false,
        askCrowd: false
    )
    @Published var currentQuestion = MillionaireQuestion(
        question: "Who scored the only goal for France in 2006 world cup final?",
        answer1: "Benzema",
        answer2: "Zidane",
        answer3: "Makelele",
        answer4: "Ribery",
        correctAnswer: "Zidane"
    )
    @Published var fiftyfiftyAnswers: [PickedAnswer] = []
    
    var size = CGSize(width: 0, height: 0)
    let player: String
    private let testQuestions: [MillionaireQuestion] = [
        MillionaireQuestion(question: "Who is the top assiter of all time?", answer1: "Özil", answer2: "Kevin De Bruyne", answer3: "Messi", answer4: "Zidane", correctAnswer: "Messi"),
        MillionaireQuestion(question: "Who scored the only goal in the world cup 2010 final?", answer1: "Robben", answer2: "Iniesta", answer3: "Higuain", answer4: "Ronaldo", correctAnswer: "Iniesta"),
        MillionaireQuestion(question: "Who scored the goal labeld as 'The hand of god'?", answer1: "Pele", answer2: "Beckenbauer", answer3: "Romario", answer4: "Maradona", correctAnswer: "Maradona")
    ]
    
    
    init(player: String) {
        self.player = player
    }
    
    func restart() {
        currentTier = .one
        updateProgress()
        lifelines.reset()
        gameState = .question
        fiftyfiftyAnswers = []
    }
    
    func updateProgress() {
        progress = currentTier.percent
    }
    
    func handleLifeline(lifeline: Lifeline) {
        
        switch lifeline {
        case .fiftyfifty:
            lifelines.fiftyfifty.toggle()
            gameState = .lifeline(.fiftyfifty)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                gameState = .question
                let correctAnswer = currentQuestion.correctAnswer
                var allAnswers = PickedAnswer.allCases
                if currentQuestion.answer1 == correctAnswer {
                    fiftyfiftyAnswers.append(.A)
                    allAnswers.removeAll(where: { $0 == .A })
                } else if currentQuestion.answer2 == correctAnswer {
                    fiftyfiftyAnswers.append(.B)
                    allAnswers.removeAll(where: { $0 == .B })
                } else if currentQuestion.answer3 == correctAnswer {
                    fiftyfiftyAnswers.append(.C)
                    allAnswers.removeAll(where: { $0 == .C })
                } else if currentQuestion.answer4 == correctAnswer {
                    fiftyfiftyAnswers.append(.D)
                    allAnswers.removeAll(where: { $0 == .D })
                }
            
                let remainingAnswers = extractRandomElementsFromArray(allAnswers, numberOfElements: 1)
                if let remainingAnswers = remainingAnswers {
                    fiftyfiftyAnswers.append(remainingAnswers[0])
                }
            }
            
        case .skipQuestion:
            lifelines.skipQuestion.toggle()
            gameState = .lifeline(.skipQuestion)
            
            currentQuestion = testQuestions[.random(in: 0...testQuestions.count - 1)]
            //fetch new question from the same tier
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                fiftyfiftyAnswers.removeAll()
                gameState = .question
                
            }
        case .askCrowd:
            lifelines.askCrowd.toggle()
            gameState = .lifeline(.askCrowd)
            DispatchQueue.main.asyncAfter(deadline: .now() + 14.5) { [self] in
                gameState = .question
            }
        }
    }
    
    func isAnswerDisabledByFiftyFifty(answer: PickedAnswer) -> Bool {
        guard !fiftyfiftyAnswers.isEmpty else { return false }
        if fiftyfiftyAnswers.contains(answer) {
            return false
        } else {
            return true
        }
    }
    
    func extractRandomElementsFromArray<Generic>(_ array: [Generic], numberOfElements: Int) -> [Generic]? {
        guard array.count >= numberOfElements else { return nil }

        var toDeplete = array
        var toReturn = [Generic]()

        while toReturn.count < numberOfElements {
            toReturn.append(toDeplete.remove(at: Int.random(in: 0..<toDeplete.count)))
        }

        return toReturn
    }
    
    
    func determineOutcome(answer: PickedAnswer) {
        switch answer {
        case .A: pickedAnswer = currentQuestion.answer1
        case .B: pickedAnswer = currentQuestion.answer2
        case .C: pickedAnswer = currentQuestion.answer3
        case .D: pickedAnswer = currentQuestion.answer4
        }
        gameState = .answerLocked
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            switch currentQuestion.correctAnswer == pickedAnswer {
            case true:
                switch currentTier {
                case .one: currentTier = .two
                case .two: currentTier = .three
                case .three: currentTier = .four
                case .four: currentTier = .five
                case .five: currentTier = .six
                case .six: currentTier = .seven
                case .seven: currentTier = .eight
                case .eight: currentTier = .nine
                case .nine: currentTier = .ten
                case .ten: currentTier = .eleven
                case .eleven: currentTier = .twelve
                case .twelve: currentTier = .thirdteen
                case .thirdteen: currentTier = .fourteen
                case .fourteen: currentTier = .fifthteen
                case .fifthteen: currentTier = .sixteen
                case .sixteen: break
                }
                gameState = .correctAnswer
                updateProgress()
                print("Correct Answer")
            case false:
                switch currentTier {
                case .one, .two, .three, .four, .five:
                    currentTier = .one
                case .six, .seven, .eight, .nine, .ten:
                    currentTier = .six
                case .eleven, .twelve, .thirdteen, .fourteen, .fifthteen, .sixteen:
                    currentTier = .eleven
                }
                gameState = .wrongAnswer
                updateProgress()
                print("Wrong answer")
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
            fiftyfiftyAnswers.removeAll()
            gameState = .question
        }
    }
    
    func nextReward() -> Tier {
        switch currentTier {
        case .one: return .two
        case .two: return .three
        case .three: return .four
        case .four: return .five
        case .five: return .six
        case .six: return .seven
        case .seven: return .eight
        case .eight: return .nine
        case .nine: return .ten
        case .ten: return .eleven
        case .eleven: return .twelve
        case .twelve: return .thirdteen
        case .thirdteen: return .fourteen
        case .fourteen: return .fifthteen
        case .fifthteen: return .sixteen
        case .sixteen: return .one
        }
    }
    
    func showRules() {
        isRulesOpen.toggle()
    }
}
