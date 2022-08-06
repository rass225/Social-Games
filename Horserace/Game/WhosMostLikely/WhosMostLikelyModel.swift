import Foundation
import SwiftUI

class WhosMostLikelyModel: ObservableObject {
    
    enum Status {
        case notStarted
        case activity
    }
    
    enum Tier: String {
        case friendly = "Friendly"
        case challenging = "Challenging"
    }
    
    @Published var tier: Tier = .friendly
    @Published var status: Status = .notStarted
    @Published var currentStatement: String = ""
    @Published var isRulesOpen: Bool = false
    
    var currentTitle: String {
        switch status {
        case .notStarted:
            return "Are you ready?"
        case .activity:
            return "Who's most likely"
        }
    }
    var mainButtonLabel: String {
        switch status {
        case .notStarted:
            return "Play"
        case .activity:
            return "Next"
        }
    }
    private var statementCollection: [WhosMostLikelyQuestion] = []
    private var statementIndex: Int = 0
    
    init() {
    }
    
    private func statementHandler() {
        if statementIndex == statementCollection.count - 1 {
            statementIndex = 0
        } else {
            statementIndex += 1
        }
        currentStatement = statementCollection[statementIndex].question
    }
    
    func fetchWhosMostLikely(tier: JSONClient.Client = .WhosMostLikelyTierOne) {
        let client = JSONClient()
        client.fetch(client: tier) { (response: Result<[WhosMostLikelyQuestion], Error>) in
            switch response {
            case .success(let success):
                self.statementCollection = success.shuffled()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func selectTier(tier: Tier) {
        if self.tier != tier {
            self.tier = tier
            status = .notStarted
            statementIndex = 0
            switch tier {
            case .friendly:
                fetchWhosMostLikely(tier: .WhosMostLikelyTierOne)
            case .challenging:
                fetchWhosMostLikely(tier: .WhosMostLikelyTierTwo)
            }
        }
    }
    
    func startGame() {
        status = .activity
    }
    
    func mainButtonAction() {
        switch status {
        case .notStarted:
                startGame()
            currentStatement = statementCollection[statementIndex].question
        case .activity:
            statementHandler()
        }
    }
    
    func showRules() {
        isRulesOpen.toggle()
    }
}
