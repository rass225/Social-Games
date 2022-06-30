import Foundation
import SwiftUI

class NeverEverModel: ObservableObject {
    
    enum GameStatus {
        case notStarted
        case activity
    }
    
    enum GameTier: String {
        case friendly = "Friendly"
        case challenging  = "Challenging"
        case naughty = "Naughty"
    }
    
    @Published var tier: GameTier = .friendly
    
//    @Published var players: [String]
    @Published var status: GameStatus = .notStarted
    @Published var currentStatement: String = ""
    @Published var currentTitle: String = ""
    @Published var statementCollection: [NeverHaveIEverQuestion] = []
    
    private var currentStatementIndex: Int = 0
    
    init() {
        titleLabel()
    }
    
    func startGame() {
        status = .activity
    }
    
    private func statementHandler() {
        if currentStatementIndex == statementCollection.count - 1 {
            currentStatementIndex = 0
        } else {
            currentStatementIndex += 1
        }
        currentStatement = statementCollection[currentStatementIndex].question
    }
    
    func mainButtonAction() {
        switch status {
        case .notStarted:
                startGame()
            currentStatement = statementCollection[currentStatementIndex].question
                titleLabel()
            
        case .activity:
//            incrementPlayer()
            statementHandler()
        }
    }
    
    func mainButtonLabel() -> String {
        switch status {
        case .notStarted:
            return "Play"
        case .activity:
            return "Next"
        }
    }
    
    private func titleLabel() {
        switch status {
        case .notStarted:
            currentTitle = "Are you ready?"
        case .activity:
            currentTitle = "Never have I ever"
        }
    }
    
    func selectTier(tier: GameTier) {
        if self.tier != tier {
            self.tier = tier
            status = .notStarted
            titleLabel()
            currentStatementIndex = 0
            switch tier {
            case .friendly:
                fetchNeverHaveIEver(tier: .NeverHaveIEverTierOne)
            case .challenging:
                fetchNeverHaveIEver(tier: .NeverHaveIEverTierTwo)
            case .naughty:
                fetchNeverHaveIEver(tier: .NeverHaveIEverTierThree)
            }
        }
    }
    
    func fetchNeverHaveIEver(tier: JSONClient.Client = .NeverHaveIEverTierOne) {
        let client = JSONClient()
        client.fetch(client: tier) { (response: Result<[NeverHaveIEverQuestion], Error>) in
            switch response {
            case .success(let success):
                self.statementCollection = success.shuffled()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
