import Foundation
import SwiftUI

class MillionaireModel: ObservableObject {
    @Published var progress: Float = 0.0
    @Published var isRulesOpen = false
    @Published var currentTier: Tier = .one
    @Published var gameState: GameState = .notStarted
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
    
    @Published var questionsFor100: [MillionaireQuestion] = []
    @Published var questionsFor200: [MillionaireQuestion] = []
    @Published var questionsFor300: [MillionaireQuestion] = []
    @Published var questionsFor500: [MillionaireQuestion] = []
    @Published var questionsFor1K: [MillionaireQuestion] = []
    @Published var questionsFor2K: [MillionaireQuestion] = []
    @Published var questionsFor4K: [MillionaireQuestion] = []
    @Published var questionsFor8K: [MillionaireQuestion] = []
    @Published var questionsFor16K: [MillionaireQuestion] = []
    @Published var questionsFor32K: [MillionaireQuestion] = []
    @Published var questionsFor64K: [MillionaireQuestion] = []
    @Published var questionsFor125K: [MillionaireQuestion] = []
    @Published var questionsFor250K: [MillionaireQuestion] = []
    @Published var questionsFor500K: [MillionaireQuestion] = []
    @Published var questionsFor1M: [MillionaireQuestion] = []
    
    var size = CGSize(width: 0, height: 0)
    let player: String
 
    
    init(player: String) {
        self.player = player
        fetchQuestions()
    }
    
    func restart() {
        currentTier = .one
        updateProgress()
        lifelines.reset()
        gameState = .notStarted
        fiftyfiftyAnswers = []
    }
    
    func tryAgain() {
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
            assignQuestion()
            
            
            
            //fetch new question from the same tier
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                fiftyfiftyAnswers.removeAll()
                gameState = .question
                
            }
        case .askCrowd:
            lifelines.askCrowd.toggle()
            gameState = .lifeline(.askCrowd)
            DispatchQueue.main.asyncAfter(deadline: .now() + 17) { [self] in
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
            if currentQuestion.correctAnswer == pickedAnswer {
                if currentTier == .sixteen {
                    gameState = .gameover
                } else {
                    gameState = .question
                    assignQuestion()
                }
            } else {
                gameState = .tryAgain
                assignQuestion()
            }
            
        }
    }
    
    func assignQuestion() {
        switch currentTier {
        case .one:
            currentQuestion = questionsFor100.randomElement()!
        case .two:
            currentQuestion = questionsFor200.randomElement()!
        case .three:
            currentQuestion = questionsFor300.randomElement()!
        case .four:
            currentQuestion = questionsFor500.randomElement()!
        case .five:
            currentQuestion = questionsFor1K.randomElement()!
        case .six:
            currentQuestion = questionsFor2K.randomElement()!
        case .seven:
            currentQuestion = questionsFor4K.randomElement()!
        case .eight:
            currentQuestion = questionsFor8K.randomElement()!
        case .nine:
            currentQuestion = questionsFor16K.randomElement()!
        case .ten:
            currentQuestion = questionsFor32K.randomElement()!
        case .eleven:
            currentQuestion = questionsFor64K.randomElement()!
        case .twelve:
            currentQuestion = questionsFor125K.randomElement()!
        case .thirdteen:
            currentQuestion = questionsFor250K.randomElement()!
        case .fourteen:
            currentQuestion = questionsFor500K.randomElement()!
        case .fifthteen:
            currentQuestion = questionsFor1M.randomElement()!
        case .sixteen:
            break
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
    
    func fetchQuestions() {
        let client = JSONClient()
        for item in Tier.allCases {
            guard item != .one else { continue }
            client.fetch(string: item.fileName) { (response: Result<[MillionaireQuestion], Error>) in
                switch response {
                case .success(let success):
                    switch item {
                    case .one:
                        break
                    case .two:
                        self.questionsFor100 = success
                        self.currentQuestion = success.randomElement()!
                        print("Success for questionsFor100")
                    case .three:
                        self.questionsFor200 = success
                        print("Success for questionsFor200")
                    case .four:
                        self.questionsFor300 = success
                        print("Success for questionsFor300")
                    case .five:
                        self.questionsFor500 = success
                        print("Success for questionsFor500")
                    case .six:
                        self.questionsFor1K = success
                        print("Success for questionsFor1K")
                    case .seven:
                        self.questionsFor2K = success
                        print("Success for questionsFor2K")
                    case .eight:
                        self.questionsFor4K = success
                        print("Success for questionsFor4K")
                    case .nine:
                        self.questionsFor8K = success
                        print("Success for questionsFor8K")
                    case .ten:
                        self.questionsFor16K = success
                        print("Success for questionsFor16K")
                    case .eleven:
                        self.questionsFor32K = success
                        print("Success for questionsFor32K")
                    case .twelve:
                        self.questionsFor64K = success
                        print("Success for questionsFor64K")
                    case .thirdteen:
                        self.questionsFor125K = success
                        print("Success for questionsFor125K")
                    case .fourteen:
                        self.questionsFor250K = success
                        print("Success for questionsFor250K")
                    case .fifthteen:
                        self.questionsFor500K = success
                        print("Success for questionsFor500K")
                    case .sixteen:
                        self.questionsFor1M = success
                        print("Success for questionsFor1M")
                    }
                    
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}

extension MillionaireModel {
    enum Tier: CaseIterable {
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
        
        var fileName: String {
            switch self {
            case .one: return "MillionaireQuestions0"
            case .two: return "MillionaireQuestions100"
            case .three: return "MillionaireQuestions200"
            case .four: return "MillionaireQuestions300"
            case .five: return "MillionaireQuestions500"
            case .six: return "MillionaireQuestions1K"
            case .seven: return "MillionaireQuestions2K"
            case .eight: return "MillionaireQuestions4K"
            case .nine: return "MillionaireQuestions8K"
            case .ten: return "MillionaireQuestions16K"
            case .eleven: return "MillionaireQuestions32K"
            case .twelve: return "MillionaireQuestions64K"
            case .thirdteen: return "MillionaireQuestions125K"
            case .fourteen: return "MillionaireQuestions250K"
            case .fifthteen: return "MillionaireQuestions500K"
            case .sixteen: return "MillionaireQuestions1M"
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
        
        var isMilestoneTier: Bool {
            switch self {
            case .one, .six, .eleven, .sixteen:
                return true
            default:
                return false
            }
        }
        
        var circleSize: Double {
            isMilestoneTier ? 16 : 10
        }
    }
    
    enum GameState: Equatable {
        case notStarted
        case question
        case answerLocked
        case lifeline(Lifeline)
        case correctAnswer
        case wrongAnswer
        case tryAgain
        case moveUp
        case gameover
        
        var image: String {
            switch self {
            case .question: return "questionmark"
            case .answerLocked: return "lock.fill"
            case .lifeline: return "waveform.path.ecg.rectangle.fill"
            case .correctAnswer: return "checkmark.circle.fill"
            case .wrongAnswer: return "x.circle.fill"
            case .moveUp: return "arrow.up.circle.fill"
            case .gameover: return "dollarsign.circle.fill"
            case .notStarted: return "house.fill"
            case .tryAgain: return "house"
            }
        }
        var label: String {
            switch self {
            case .question: return ""
            case .answerLocked: return "You locked your answer"
            case .lifeline(let choice):
                return "\(choice.label)"
            case .moveUp: return "You have progressed to the next stage"
            case .gameover: return "You won!"
            case .correctAnswer: return "Correct Answer"
            case .wrongAnswer: return "Wrong Answer"
            case .notStarted: return "Welcome to the game!"
            case .tryAgain: return "You lost"
            }
        }
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
}
