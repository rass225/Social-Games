import Foundation
import SwiftUI

class NeverEverModel: ObservableObject {
    
    enum GameStatus {
        case notStarted
        case activity
    }
    
    enum GameTier {
        case friendly
        case challenging
        case naughty
    }
    
    @Published var tier: GameTier = .friendly
    
    @Published var players: [String]
    @Published var status: GameStatus = .notStarted
    @Published var currentPlayer: Int = 0
    @Published var currentStatement: String = ""
    @Published var currentTitle: String = ""
    @Published var statementCollection: [NeverHaveIEverQuestion] = []
    
    private var currentStatementIndex: Int = 0
//    private var statements: [String] = ["Played basketball", "Farted in a classroom", "Scored a goal", "Driven a car", "Lied to someone's face", "Thrown up because of alcohol"]
    
    init(players: [String]) {
        self.players = players
        titleLabel()
    }
    
    
    func startGame() {
        status = .activity
    }
    
    func statementHandler() {
        if currentStatementIndex == statementCollection.count - 1 {
            currentStatementIndex = 0
        } else {
            currentStatementIndex += 1
        }
        currentStatement = statementCollection[currentStatementIndex].question
    }
    

    func incrementPlayer() {
        if currentPlayer == 10 {
            currentPlayer = 0
            return
        }
        if currentPlayer == players.count - 1 {
            currentPlayer = 0
        } else {
            currentPlayer += 1
        }
    }
    
    func mainButtonAction() {
        switch status {
        case .notStarted:
                startGame()
            currentStatement = statementCollection[currentStatementIndex].question
                titleLabel()
            
        case .activity:
            incrementPlayer()
            statementHandler()
        }
    }
    
    func mainButtonLabel() -> String {
        switch status {
        case .notStarted:
            return "Play"
        case .activity:
            return "Next Player"
        }
    }
    
    func titleLabel() {
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
            currentPlayer = 0
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
