import Foundation
import SwiftUI

class TruthOrDareModel: ObservableObject {
    
    enum GameStatus {
        case notStarted
        case truthOrDare
        case activity
    }
    
    enum TruthOrDare {
        case truth
        case dare
    }
    
    enum TruthOrDareTier {
        case friendly
        case challenging
        case naughty
    }
    
    let players: [String]
    
    @Published var tier: TruthOrDareTier = .friendly
    @Published var status: GameStatus = .notStarted
    @Published var truthOrDare: TruthOrDare = .truth
    @Published var currentPlayer: Int = 0
    @Published var label: String = ""
    @Published var title: String = ""
    @Published var truthCollection: [Truth] = []
    @Published var dareCollection: [Dare] = []
    
    private var currentTruthIndex: Int = 0
    private var currentDareIndex: Int = 0
    
    init(players: [String]) {
        self.players = players
        titleHandler()
        
    }
    
    func restart() {
        currentPlayer = 10
        status = .notStarted
        dareCollection.shuffle()
        truthCollection.shuffle()
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
    
    func truthHandler() {
        status = .activity
        truthOrDare = .truth
        
        if currentTruthIndex == truthCollection.count - 1 {
            currentTruthIndex = 0
        } else {
            currentTruthIndex += 1
        }
        label = truthCollection[currentTruthIndex].question
    }
    
    func dareHandler() {
        status = .activity
        truthOrDare = .dare
        if currentDareIndex == dareCollection.count - 1 {
            currentDareIndex = 0
        } else {
            currentDareIndex += 1
        }
        label = dareCollection[currentDareIndex].question
    }
    
    func titleHandler() {
        switch status {
        case .notStarted:
            title = "Are you ready?"
        case .truthOrDare:
            title = "Choose"
        case .activity:
            switch truthOrDare {
            case .truth:
                title = "Truth"
            case .dare:
                title = "Dare"
            }
            
        }
    }
    
    func fetchTruth(tier: JSONClient.Client = .TruthTierOne) {
        let client = JSONClient()
        client.fetch(client: tier) { (response: Result<[Truth], Error>) in
            switch response {
            case .success(let success):
                self.truthCollection = success.shuffled()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchDare(tier: JSONClient.Client = .DareTierOne) {
        let client = JSONClient()
        client.fetch(client: tier) { (response: Result<[Dare], Error>) in
            switch response {
            case .success(let success):
                self.dareCollection = success.shuffled()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func selectTier(tier: TruthOrDareTier) {
        if self.tier != tier {
            self.tier = tier
            status = .notStarted
            titleHandler()
            currentPlayer = 0
            switch tier {
            case .friendly:
                fetchTruth(tier: .TruthTierOne)
                fetchDare(tier: .DareTierOne)
            case .challenging:
                fetchTruth(tier: .TruthTierTwo)
                fetchDare(tier: .DareTierTwo)
            case .naughty:
                fetchTruth(tier: .TruthTierThree)
                fetchDare(tier: .DareTierThree)
            }
            
        }
    }
}

