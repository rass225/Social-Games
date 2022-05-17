import Foundation
import SwiftUI

class NeverEverModel: ObservableObject {
    
    enum GameStatus {
        case notStarted
        case activity
    }
    
    @Published var players: [String]
    @Published var status: GameStatus = .notStarted
    @Published var currentPlayer: Int = 10
    @Published var currentStatement: String = ""
    @Published var currentTitle: String = ""
    
    private var currentStatementIndex: Int = 0
    private var statements: [String] = ["Played basketball", "Farted in a classroom", "Scored a goal", "Driven a car", "Lied to someone's face", "Thrown up because of alcohol"]
    
    init(players: [String]) {
        self.players = players
        titleLabel()
    }
    
    
    func startGame() {
        status = .activity
    }
    
    func statementHandler() {
        if currentStatementIndex == statements.count - 1 {
            currentStatementIndex = 0
        } else {
            currentStatementIndex += 1
        }
        currentStatement = statements[currentStatementIndex]
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
            withAnimation{
                startGame()
                incrementPlayer()
                currentStatement = statements[currentStatementIndex]
                titleLabel()
            }
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
}
