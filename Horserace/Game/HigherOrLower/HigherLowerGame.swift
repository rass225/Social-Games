import SwiftUI

struct HigherLowerGame: View {
    
//    @ObservedObject var model: HigherLowerModel
    @State var isRulesOpen: Bool = false
    
//    init(players: [String]) {
//        model = HigherLowerModel(players: players)
//    }
    
    enum Choice {
        case higher
        case lower
    }
    
    let players: [String]
    @State var currentPlayer = 0
    @State var deck = Constant.deck.shuffled()
    @State var hasPlayersShuffled: Bool = false
    
    @State var leftCardRotation = CardRotation(front: 0, back: 90)
    @State var rightCardRotation = CardRotation(front: 90, back: 0)
    @State var rightSecondCardRotation = CardRotation(front: 90, back: 0)
    @State var offsetX: CGFloat = 0
    
    @State var dealtCards: [Deck] = []
    @State var undealtCards: [Deck] = []
    @State var nextCardToAddIndex = 0
    @State var choiceMade: Choice = .higher
    @State var isAnimating: Bool = false
    @State var mainLabel: String = "Higher or lower?"
    @State var currentStreak: Int = 0
    
    
    var body: some View {
        VStack{
            PlayersBoard(currentPlayer: $currentPlayer, hasPlayersShuffled: $hasPlayersShuffled, players: players)
            
            GeometryReader { geo in
                let size = geo.size
                Text(mainLabel)
                    .font(.title3.weight(.regular))
                    .foregroundColor(Colors.text)
                    .maxWidth(alignment: .center)
                    .padding(.top, 32)
                    
                   
                VStack{
                    Spacer()
                    Text("Current streak: \(currentStreak)")
                        .textCase(.uppercase)
                        .font(.headline.weight(.medium))
                    HStack(spacing: 20){
                        ZStack{
                            ForEach($dealtCards) { item in
                                FullCard(card: item, rotation: $leftCardRotation, size: .extraLarge, geo: size)
                            }
                        }
                        ZStack{
                            ForEach(undealtCards.indices, id: \.self) { index in
                                if index == undealtCards.count - 1 {
                                    FullCard(card: $undealtCards[index], rotation: $rightCardRotation, size: .extraLarge, geo: size)
                                        .offset(x: offsetX, y: 0)
                                } else {
                                    FullCard(card: $undealtCards[index], rotation: $rightSecondCardRotation, size: .extraLarge, geo: size)
                                }
                            }
                        }
                    }
                    .maxWidth()
                   
                    
                    Spacer()
                }
                VStack{
                    Spacer()
                    HStack(spacing: 16){
                        Button(action: {
                            choiceMade = .higher
                            mainAction(size: size)
                        }) {
                            MainButton(label: "Higher")
                        }
                        .disabled(isAnimating)
                        .opacity(isAnimating ? 0.4 : 1)
                        Button(action: {
                            choiceMade = .lower
                            mainAction(size: size)
                        }) {
                            MainButton(label: "Lower")
                        }
                        .disabled(isAnimating)
                        .opacity(isAnimating ? 0.4 : 1)
                    }
                }
            }
        }
        .navigationModifier(game: .higherLower)
        .gameViewModifier(game: .higherLower)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                HomeButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    restart()
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
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
        .onAppear{
            initialize()
        }
    }
    
    func mainAction(size: CGSize) {
        mainLabel = ""
        isAnimating.toggle()
        currentStreak += 1
        withAnimation(Animation.easeIn(duration: 0.6).delay(1.7)) {
            offsetX = (size.height / 4.5 * -1) - 20
        }
        withAnimation(Animation.easeOut(duration: 0.5)) {
            rightCardRotation.back = -90
           
        }
        withAnimation(Animation.easeOut(duration: 0.5).delay(0.5)) {
            rightCardRotation.front = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            determineOutcome()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
            transferToDealtDeck()
            addCardToUndealtDeck()
            incrementPlayer()
            for item in dealtCards {
                print("\(item.rank) of \(item.suit)")
            }
            isAnimating.toggle()
        }
        
        if nextCardToAddIndex == deck.count - 1 {
            deck.shuffle()
            nextCardToAddIndex = 0
        }
    }
    
    func determineOutcome() {
        let baseCard = dealtCards[dealtCards.count - 1].rank.number
        let compareCard = undealtCards[undealtCards.count - 1].rank.number
        switch choiceMade {
        case .higher:
            if compareCard > baseCard {
                
                print("Winner")
            } else {
                let penalty = currentStreak
                let currentPlayer = players[currentPlayer]
                mainLabel = "\(currentPlayer) lost with \(penalty) penalty points."
                currentStreak = 0
                print("loser")
            }
        case .lower:
            if compareCard < baseCard {
                print("Winner")
            } else {
                let penalty = currentStreak
                let currentPlayer = players[currentPlayer]
                mainLabel = "\(currentPlayer) lost with \(penalty) penalty points."
                currentStreak = 0
                print("loser")
            }
        }
    }
    
    func initialize() {
        dealtCards.append(deck[0])
        undealtCards.append(deck[1])
        undealtCards.append(deck[2])
        nextCardToAddIndex = 3
    }
    
    func restart() {
        withAnimation(Animation.easeInOut(duration: 0.4)) {
            rightCardRotation.front = 90
        }
        withAnimation(Animation.easeInOut(duration: 0.4).delay(0.4)) {
            rightCardRotation.back = 0
        }
        withAnimation(Animation.easeIn(duration: 1.2)) {
            offsetX = 0
        }
    }
    
    func transferToDealtDeck() {
        dealtCards.append(undealtCards[undealtCards.count - 1])
        dealtCards.removeFirst()
        undealtCards.removeFirst()
        hardResetRotation()
    }
    
    func hardResetRotation() {
        rightCardRotation.front = 90
        rightCardRotation.back = 0
        offsetX = 0
    }
    
    func addCardToUndealtDeck() {
        undealtCards.append(deck[nextCardToAddIndex])
        nextCardToAddIndex += 1
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
}
