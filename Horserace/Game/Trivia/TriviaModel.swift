import Foundation
import SwiftUI

class TriviaModel: ObservableObject {
    
    @Published var state: GameState = .category
    @Published var pickedCategory: Category = .none
    @Published var isAnswerRevealed = false
    @Published var title = ""
    @Published var question: TriviaQuestion = TriviaQuestion(question: "", answer: "", answerDescription: "", a: "", b: "", c: "", d: "")
    var mainButtonLabel: String {
        switch isAnswerRevealed {
        case true: return "Next Question"
        case false: return "Reveal Answer"
        }
    }
    
    private var geographyQuestions: [TriviaQuestion] = [TriviaQuestion(question: "What razor-thin country accounts for more than half of the western coastline of South America?", answer: "Chile", answerDescription: "With a toothy coastline of 2,650 miles (4,265 km), Chile accounts for more than half of the western coastline of South America. This razor-thin country is wedged between the Pacific Ocean and the Andes, the Earth's longest mountain range.", a: "Chile", b: "Bolivia", c: "Ecuador", d: "Peru")]
    private var sportsQuestions: [TriviaQuestion] = []
    private var movieQuestions: [TriviaQuestion] = []
    private var historyQuestions: [TriviaQuestion] = []
    private var scienceQuestions: [TriviaQuestion] = []
    private var musicQuestions: [TriviaQuestion] = []
    
    private var geographyIndex: Int = 0
    private var sportsIndex: Int = 0
    private var movieIndex: Int = 0
    private var historyIndex: Int = 0
    private var scienceIndex: Int = 0
    private var musicIndex: Int = 0
    
    init() {
        fetchCategory(tier: .TriviaGeography, category: .geography)
        fetchCategory(tier: .TriviaSports, category: .sports)
        fetchCategory(tier: .TriviaMovies, category: .movie)
        fetchCategory(tier: .TriviaScience, category: .science)
        fetchCategory(tier: .TriviaHistory, category: .history)
        fetchCategory(tier: .TriviaMusic, category: .music)
    }
    
    enum GameState {
        case category
        case game
    }
    
    enum Category: String {
        case geography = "Geography"
        case sports = "Sports"
        case movie = "Movie"
        case history = "History"
        case science = "Science"
        case music = "Music"
        case none
        
        var image: Image {
            switch self {
            case .geography: return Image("globe")
            case .sports: return Image("sports")
            case .movie: return Image("movie")
            case .history: return Image("history")
            case .science: return Image("science")
            case .music: return Image("music")
            case .none: return Images.shield
            }
        }
    }
    
    func pickCategory(category: Category) {
        pickedCategory = category
        title = category.rawValue
        withAnimation(.easeInOut(duration: 0.5)) {
            state = .game
        }
        switch category {
        case .geography:
            question = geographyQuestions[geographyIndex]
        case .sports:
            question = sportsQuestions[sportsIndex]
        case .movie:
            question = movieQuestions[movieIndex]
        case .history:
            question = historyQuestions[historyIndex]
        case .science:
            question = scienceQuestions[scienceIndex]
        case .music:
            question = musicQuestions[musicIndex]
        case .none:
            question = musicQuestions[0]
        }
        
    }
    
    func mainButtonAction() {
        if isAnswerRevealed {
            nextQuestion()
        } else {
            revealAnswer()
        }
    }
    
    func revealAnswer() {
        isAnswerRevealed.toggle()
    }
    
    func nextQuestion() {
        withAnimation(.easeOut(duration: 0.5)){
            state = .category
        }
        
        switch pickedCategory {
        case .geography:
            if geographyIndex < geographyQuestions.count - 1 {
                geographyIndex += 1
            } else {
                geographyIndex = 0
                geographyQuestions.shuffle()
            }
        case .sports:
            if sportsIndex < sportsQuestions.count - 1 {
                sportsIndex += 1
            } else {
                sportsIndex = 0
                sportsQuestions.shuffle()
            }
        case .movie:
            if movieIndex < movieQuestions.count - 1 {
                movieIndex += 1
            } else {
                movieIndex = 0
                movieQuestions.shuffle()
            }
        case .history:
            if historyIndex < historyQuestions.count - 1 {
                historyIndex += 1
            } else {
                historyIndex = 0
                historyQuestions.shuffle()
            }
        case .science:
            if scienceIndex < scienceQuestions.count - 1 {
                scienceIndex += 1
            } else {
                scienceIndex = 0
                scienceQuestions.shuffle()
            }
        case .music:
            if musicIndex < musicQuestions.count - 1 {
                musicIndex += 1
            } else {
                musicIndex = 0
                musicQuestions.shuffle()
            }
        case .none: break
        }
        isAnswerRevealed.toggle()
    }
    
    func fetchCategory(tier: JSONClient.Client = .TriviaGeography, category: Category) {
        let client = JSONClient()
        client.fetch(client: tier) { (response: Result<[TriviaQuestion], Error>) in
            switch response {
            case .success(let success):
                switch category {
                case .geography:
                    self.geographyQuestions = success.shuffled()
                case .sports:
                    self.sportsQuestions = success.shuffled()
                case .movie:
                    self.movieQuestions = success.shuffled()
                case .history:
                    self.historyQuestions = success.shuffled()
                case .science:
                    self.scienceQuestions = success.shuffled()
                case .music:
                    self.musicQuestions = success.shuffled()
                case .none:
                    break
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
