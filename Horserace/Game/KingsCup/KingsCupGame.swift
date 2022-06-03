import SwiftUI

struct KingsCupGame: View {
    
    enum Status {
        case notStarted
        case game
        case gameOver
    }
    @EnvironmentObject var game: Game
    @EnvironmentObject var appState: AppState
    @State private var deck = Constant.deck.shuffled()
    @State private var isDiamondKingPicked: Bool = false
    @State private var isHeartKingPicked: Bool = false
    @State private var isSpadeKingPicked: Bool = false
    @State private var isClubKingPicked: Bool = false
    @State private var rule = KingsCupRule(title: "", rule: "")
    @State private var gameStatus: Status = .notStarted
    @State private var deckIndex: Int = 0
    @State private var cupPercent: Double = 0
    @State var isRulesOpen: Bool = false
    @State var currentPlayer: Int = 0
    @State var showGameOver: Bool = false
    
    let players: [String]
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                let size = geometry.size
                
                VStack(spacing: 0){
                    HStack(spacing: 16){
                        Spacer()
                        Card(suit: .heart, rank: .king, size: .small, geometry: size)
                            .opacity(isHeartKingPicked ? 1 : 0.4)
                            .animation(.easeOut(duration: 2), value: isHeartKingPicked)
                        Card(suit: .diamond, rank: .king, size: .small, geometry: size)
                            .opacity(isDiamondKingPicked ? 1 : 0.4)
                            .animation(.easeOut(duration: 2), value: isDiamondKingPicked)
                        CircleWaveView(percent: cupPercent)
                            .frame(width: size.height / 7, height: size.height / 5)
                        Card(suit: .spades, rank: .king, size: .small, geometry: size)
                            .opacity(isSpadeKingPicked ? 1 : 0.4)
                            .animation(.easeOut(duration: 2), value: isSpadeKingPicked)
                        Card(suit: .clubs, rank: .king, size: .small, geometry: size)
                            .opacity(isClubKingPicked ? 1 : 0.4)
                            .animation(.easeOut(duration: 2), value: isClubKingPicked)
                        Spacer()
                    }
                    .padding(.vertical, 32)
                    
                    DescriptionView(title: $rule.title, rule: $rule.rule)
                        .padding(.top)
                    Spacer()
                    VStack{
                        switch gameStatus {
                        case .notStarted:
                            CardBack(size: .large, geometry: size).opacity(0.4)
                        case .game, .gameOver:
                            Text("\(deck.count - deckIndex - 1) remaining")
                                .font(.subheadline.weight(.regular))
                            Card(suit: deck[deckIndex].suit, rank: deck[deckIndex].rank, size: .large, geometry: size)
                        }
                    }.padding(.bottom)
                }
            }
            VStack(spacing: 4){
                HStack{
                    Text("Current player: \(players[currentPlayer])")
                    Spacer()
                    Text("Next player: \(nextPlayer())")
                }
                .padding(.horizontal, 12)
                .foregroundColor(Colors.text)
                .font(.footnote)
                .opacity(gameStatus == .game ? 1 : 0)
                Button(action: {
                    mainButton()
                }) {
                    MainButton(label: gameStatus == .game ? "Next Card" : "Play")
                }
                .opacity(gameStatus == .gameOver ? 0 : 1)
                .disabled(gameStatus == .gameOver ? true : false)
                .buttonStyle(PlainButtonStyle())
            }.padding(.top, 32)
        }
        .gameViewModifier(game: .kingsCup)
        .navigationModifier(game: .kingsCup)
        
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
        .sheet(isPresented: $showGameOver) {
            gameOver 
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                HomeButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    restartGame()
                }) {
                    RestartButton()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesButton(isOpen: $isRulesOpen)
            }
            ToolbarItem(placement: .principal) {
                GameTitle()
            }
        }
    }
    
    func gameLogic() {
        deckIndex += 1
        incrementPlayer()
        displayRule()
        checkKing()
    }
    
    func displayRule() {
        switch deck[deckIndex].rank {
        case .two  : rule = Constant.KingsCupRules.two
        case .three: rule = Constant.KingsCupRules.three
        case .four : rule = Constant.KingsCupRules.four
        case .five : rule = Constant.KingsCupRules.five
        case .six  : rule = Constant.KingsCupRules.six
        case .seven: rule = Constant.KingsCupRules.seven
        case .eight: rule = Constant.KingsCupRules.eight
        case .nine : rule = Constant.KingsCupRules.nine
        case .ten  : rule = Constant.KingsCupRules.ten
        case .jack : rule = Constant.KingsCupRules.jack
        case .queen: rule = Constant.KingsCupRules.queen
        case .king : rule = Constant.KingsCupRules.king
        case .ace  : rule = Constant.KingsCupRules.ace
        }
    }
    
    func checkKing() {
        let animation: Animation = .easeOut(duration: 2)
        if deck[deckIndex].rank == .king {
            switch deck[deckIndex].suit {
            case .heart:
                isHeartKingPicked.toggle()
                withAnimation(animation) {
                    cupPercent = cupPercent + 0.25
                }
            case .diamond:
                isDiamondKingPicked.toggle()
                withAnimation(animation) {
                    cupPercent = cupPercent + 0.25
                }
            case .spades:
                isSpadeKingPicked.toggle()
                withAnimation(animation) {
                    cupPercent = cupPercent + 0.25
                }
            case .clubs:
                isClubKingPicked.toggle()
                withAnimation(animation) {
                    cupPercent = cupPercent + 0.25
                }
            }
        }
        
        if isHeartKingPicked && isDiamondKingPicked && isSpadeKingPicked && isClubKingPicked {
            gameStatus = .gameOver
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("Game Over")
                showGameOver.toggle()
            }
        }
    }
    
    func mainButton() {
        switch gameStatus {
        case .notStarted:
            startGame()
        case .game:
            gameLogic()
        case .gameOver:
            break
        }
    }
    
    func startGame() {
        gameStatus = .game
        displayRule()
        checkKing()
    }
    
    func restartGame() {
        gameStatus = .notStarted
        isClubKingPicked = false
        isSpadeKingPicked = false
        isDiamondKingPicked = false
        isHeartKingPicked = false
        rule.rule = ""
        rule.title = ""
        deckIndex = 0
        cupPercent = 0
        deck = deck.shuffled()
    }
    
    func incrementPlayer() {
        if currentPlayer == players.count - 1 {
            currentPlayer = 0
        } else {
            currentPlayer += 1
        }
    }
    
    func nextPlayer() -> String {
        if currentPlayer == players.count - 1 {
            return players[0]
        } else {
            return players[currentPlayer + 1]
        }
    }
}




