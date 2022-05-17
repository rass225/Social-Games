import Foundation
import SwiftUI

class RouletteModel: ObservableObject {
    
    let players: [String]
    
    @Published var currentPlayer: Int = 0
    @Published var isAnimating: Bool = false
    @Published var spinDegrees: Double = 0.0
    @Published var rand: Double = 0.0
    @Published var newAngle: Double = 0.0
    
    @Published var landingSector: Sector?
    @Published var title: String = "Welcome to roulette"
    @Published var placedBet: BetType = .none
    @Published var status: GameStatus = .notStarted
    @Published var mainButtonLabel: String = ""
    
    let halfSector = 360.0 / 37.0 / 2.0
    let sectors: [Sector] = [Sector(number: 32, color: .red), Sector(number: 15, color: .black), Sector(number: 19, color: .red), Sector(number: 4, color: .black), Sector(number: 21, color: .red), Sector(number: 2, color: .black), Sector(number: 25, color: .red), Sector(number: 17, color: .black), Sector(number: 34, color: .red), Sector(number: 6, color: .black), Sector(number: 27, color: .red), Sector(number: 13, color: .black), Sector(number: 36, color: .red), Sector(number: 11, color: .black), Sector(number: 30, color: .red), Sector(number: 8, color: .black), Sector(number: 23, color: .red), Sector(number: 10, color: .black), Sector(number: 5, color: .red), Sector(number: 24, color: .black), Sector(number: 16, color: .red), Sector(number: 33, color: .black), Sector(number: 1, color: .red), Sector(number: 20, color: .black), Sector(number: 14, color: .red), Sector(number: 31, color: .black), Sector(number: 9, color: .red), Sector(number: 22, color: .black), Sector(number: 18, color: .red), Sector(number: 29, color: .black), Sector(number: 7, color: .red), Sector(number: 28, color: .black), Sector(number: 12, color: .red), Sector(number: 35, color: .black), Sector(number: 3, color: .red), Sector(number: 26, color: .black), Sector(number: 0, color: .green)]
    
    init(players: [String]) {
        self.players = players
        setMainButtonLabel()
    }
    
    struct Sector: Equatable {
        let number: Int
        let color: Color
    }
    
    enum BetType: String {
        case firstQ = "1 - 12"
        case secondQ = "13 - 24"
        case thirdQ = "25 - 36"
        case firstHalf = "1 - 18"
        case secondHalf = "19 - 36"
        case red = "Red"
        case black = "Black"
        case odd = "Odd"
        case even = "Even"
        case none
    }
    
    enum GameStatus {
        case notStarted
        case betting
        case roulette
    }
    
    func setMainButtonLabel() {
        switch status {
        case .notStarted:
            mainButtonLabel = "Play"
        case .betting:
            mainButtonLabel = "Spin"
        case .roulette:
            mainButtonLabel = "Next player"
        }
    }
    
    func mainAction() {
        switch status {
        case .notStarted:
            self.status = .betting
            self.title = "Place your bet"
            self.currentPlayer = 0
            setMainButtonLabel()
        case .betting:
            status = .roulette
            isAnimating = true
            rand = Double.random(in: 1...360)
            spinDegrees += 1080.0 + rand
            newAngle = getAngle(angle: spinDegrees)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.9) {
                self.isAnimating = false
                self.sectorFromAngle(angle: self.newAngle)
            }
            setMainButtonLabel()
        case .roulette:
            incrementPlayer()
            status = .betting
            placedBet = .none
            landingSector = nil
            title = "Place your bet"
            setMainButtonLabel()
        }
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

    
    func getAngle(angle: Double) -> Double {
        let deg = 360 - angle.truncatingRemainder(dividingBy: 360)
        return deg
    }
    
    func sectorFromAngle(angle: Double){
        var i = 0
        var sector: Sector = Sector(number: -1, color: .blue)
        while sector == Sector(number: -1, color: .blue) && i < sectors.count {
            let start: Double = halfSector * Double((i*2 + 1)) - halfSector
            let end: Double = halfSector * Double((i*2 + 3))
            
            if(angle >= start && angle < end) {
                sector = sectors[i]
            }
            i+=1
        }
        landingSector = sector
        determineWin()
    }
    
    func determineWin() {
        guard let landingSector = landingSector else { return }
        let number = landingSector.number
        let color = landingSector.color
        
        guard landingSector.number != 0 else {
            displayOutcome(didWin: false)
            return
        }

        switch placedBet {
        case .firstQ: displayOutcome(didWin: number <= 12)
        case .secondQ: displayOutcome(didWin: number >= 13 && number <= 24)
        case .thirdQ: displayOutcome(didWin: number >= 25)
        case .firstHalf: displayOutcome(didWin: number <= 18)
        case .secondHalf: displayOutcome(didWin: number >= 19)
        case .red: displayOutcome(didWin: color == .red)
        case .black: displayOutcome(didWin: color == .black)
        case .odd: displayOutcome(didWin: !number.isMultiple(of: 2))
        case .even: displayOutcome(didWin: number.isMultiple(of: 2))
        case .none: title = ""
        }
    }
    
    func displayOutcome(didWin: Bool) {
        let winLabel = "\(players[currentPlayer]) won the bet"
        let lossLabel = "\(players[currentPlayer]) lost the bet"
        switch didWin {
        case true:
            title = winLabel
        case false:
            title = lossLabel
        }
    }
}
