import SwiftUI

struct PyramidGame: View {
    
    enum Base {
        case first
        case second
        case third
        case fourth
        case fifth
    }
    
    @EnvironmentObject var appState: AppState
    @State private var currentPlayer: Int = 0
    @State var isRulesOpen: Bool = false
    
    let players: [String]
    @State private var deck = Constant.deck.shuffled()
    @State private var substituteIndex: Int = 15
    @State private var currentPath: [Int] = []
    @State private var currentBase: Base = .first
    @State private var firstBasefirst: CardRotation = CardRotation(front: 90, back: 0)
    @State private var firstBaseSecond: CardRotation = CardRotation(front: 90, back: 0)
    @State private var firstBaseThird: CardRotation = CardRotation(front: 90, back: 0)
    @State private var firstBaseFourth: CardRotation = CardRotation(front: 90, back: 0)
    @State private var firstBaseFifth: CardRotation = CardRotation(front: 90, back: 0)
    @State private var secondBaseFirst: CardRotation = CardRotation(front: 90, back: 0)
    @State private var secondBaseSecond: CardRotation = CardRotation(front: 90, back: 0)
    @State private var secondBaseThird: CardRotation = CardRotation(front: 90, back: 0)
    @State private var secondBaseFourth: CardRotation = CardRotation(front: 90, back: 0)
    @State private var thirdBaseFirst: CardRotation = CardRotation(front: 90, back: 0)
    @State private var thirdBaseSecond: CardRotation = CardRotation(front: 90, back: 0)
    @State private var thirdBaseThird: CardRotation = CardRotation(front: 90, back: 0)
    @State private var fourthBaseFirst: CardRotation = CardRotation(front: 90, back: 0)
    @State private var fourthBaseSecond: CardRotation = CardRotation(front: 90, back: 0)
    @State private var fifthBase: CardRotation = CardRotation(front: 90, back: 0)
    @State private var mainLabel: String = "."
    @State private var mainLabelOpacity: Double = 0
    @State private var firstBaseOpacity: Double = 1
    @State private var secondBaseOpacity: Double = 0.6
    @State private var thirdBaseOpacity: Double = 0.45
    @State private var fourthBaseOpacity: Double = 0.3
    @State private var fifthBaseOpacity: Double = 0.1
    
    var body: some View {
        VStack(spacing: 16){
            PlayersBoard(currentPlayer: $currentPlayer, players: players)
                .padding(.bottom, 32)
            
            
            
            GeometryReader { geometry in
                let size = geometry.size
                VStack(spacing: 12){
                    Spacer()
                    HStack{
                        FullCard(card: $deck[0], rotation: $fifthBase, size: .medium, geo: size)
                            .onTapGesture {  gameLogic(index: 0) }
                            .disabled(currentBase == .fifth ? false : true)
                            .opacity(fifthBaseOpacity)
                            .animation(.linear(duration: 1), value: fifthBaseOpacity)
                    }
                    HStack(spacing: 16){
                        FullCard(card: $deck[1], rotation: $fourthBaseFirst, size: .medium, geo: size)
                            .onTapGesture {  gameLogic(index: 1) }
                            .disabled(currentBase == .fourth ? false : true)
                            .opacity(fourthBaseOpacity)
                            .animation(.linear(duration: 1), value: fourthBaseOpacity)
                        FullCard(card: $deck[2], rotation: $fourthBaseSecond, size: .medium, geo: size)
                            .onTapGesture {  gameLogic(index: 2) }
                            .disabled(currentBase == .fourth ? false : true)
                            .opacity(fourthBaseOpacity)
                            .animation(.linear(duration: 1), value: fourthBaseOpacity)
                    }
                    HStack(spacing: 16){
                        FullCard(card: $deck[3], rotation: $thirdBaseFirst, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 3) }
                            .disabled(currentBase == .third ? false : true)
                            .opacity(thirdBaseOpacity)
                            .animation(.linear(duration: 1), value: thirdBaseOpacity)
                        FullCard(card: $deck[4], rotation: $thirdBaseSecond, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 4) }
                            .disabled(currentBase == .third ? false : true)
                            .opacity(thirdBaseOpacity)
                            .animation(.linear(duration: 1), value: thirdBaseOpacity)
                        FullCard(card: $deck[5], rotation: $thirdBaseThird, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 5) }
                            .disabled(currentBase == .third ? false : true)
                            .opacity(thirdBaseOpacity)
                            .animation(.linear(duration: 1), value: thirdBaseOpacity)
                    }
                    HStack(spacing: 16){
                        FullCard(card: $deck[6], rotation: $secondBaseFirst, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 6) }
                            .disabled(currentBase == .second ? false : true)
                            .opacity(secondBaseOpacity)
                            .animation(.linear(duration: 1), value: secondBaseOpacity)
                        FullCard(card: $deck[7], rotation: $secondBaseSecond, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 7) }
                            .disabled(currentBase == .second ? false : true)
                            .opacity(secondBaseOpacity)
                            .animation(.linear(duration: 1), value: secondBaseOpacity)
                        FullCard(card: $deck[8], rotation: $secondBaseThird, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 8) }
                            .disabled(currentBase == .second ? false : true)
                            .opacity(secondBaseOpacity)
                            .animation(.linear(duration: 1), value: secondBaseOpacity)
                        FullCard(card: $deck[9], rotation: $secondBaseFourth, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 9) }
                            .disabled(currentBase == .second ? false : true)
                            .opacity(secondBaseOpacity)
                            .animation(.linear(duration: 1), value: secondBaseOpacity)
                    }
                    HStack(spacing: 16){
                        FullCard(card: $deck[10], rotation: $firstBasefirst, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 10) }
                            .disabled(currentBase == .first ? false : true)
                            .opacity(firstBaseOpacity)
                            .animation(.linear(duration: 1), value: firstBaseOpacity)
                        FullCard(card: $deck[11], rotation: $firstBaseSecond, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 11) }
                            .disabled(currentBase == .first ? false : true)
                            .opacity(firstBaseOpacity)
                            .animation(.linear(duration: 1), value: firstBaseOpacity)
                        FullCard(card: $deck[12], rotation: $firstBaseThird, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 12) }
                            .disabled(currentBase == .first ? false : true)
                            .opacity(firstBaseOpacity)
                            .animation(.linear(duration: 1), value: firstBaseOpacity)
                        FullCard(card: $deck[13], rotation: $firstBaseFourth, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 13) }
                            .disabled(currentBase == .first ? false : true)
                            .opacity(firstBaseOpacity)
                            .animation(.linear(duration: 1), value: firstBaseOpacity)
                        FullCard(card: $deck[14], rotation: $firstBaseFifth, size: .medium, geo: size)
                            .onTapGesture { gameLogic(index: 14) }
                            .disabled(currentBase == .first ? false : true)
                            .opacity(firstBaseOpacity)
                            .animation(.linear(duration: 1), value: firstBaseOpacity)
                    }
                    Spacer()
                }
                .maxWidth()
                
                .overlay(alignment: .center) {
                    Text(mainLabel)
                        .font(.title3.weight(.regular))
                        .foregroundColor(Colors.text)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                        .opacity(mainLabelOpacity)
                }
            }
            .padding(.bottom, 24)
            .padding(.bottom, 16)
            .padding(.horizontal)
        }
        .gameViewModifier(game: .pyramid)
        .navigationModifier(game: .pyramid)
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                MainMenuMenuButton()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    restart()
                }) {
                    Images.restartFill
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Colors.text, .thinMaterial)
                        
                        .font(.title)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesMenuButton(isOpen: $isRulesOpen)
            }
            GameTitle(game: .pyramid)
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
    
    func gameLogic(index: Int) {
        flipFaceUp(index: index)
        addToPath(index: index)
        
        if isFaceCard(deck: deck[index]) {
            revealPunishment()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                currentBase = .first
                flipFaceDown()
                updateOpacity()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                replaceCards()
            }
        } else {
            mainLabelOpacity = 0
            if currentBase == .fifth {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    flipFaceDown()
                    updateOpacity()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    incrementPlayer()
                    mainLabel = "\(players[currentPlayer])'s turn"
                    mainLabelOpacity = 1
                    replaceCards()
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    updateOpacity()
                }
            }
            changeBase(index: index)
        }
    }
    
    func isFaceCard(deck: Deck) -> Bool {
        if deck.rank == .ace { return true }
        if deck.rank == .king { return true }
        if deck.rank == .queen { return true }
        if deck.rank == .jack { return true }
        return false
    }
    
    func flipFaceUp(index: Int) {
        withAnimation(Animation.easeOut(duration: 0.5)){
            switch index {
            case 0: fifthBase.back = -90
            case 1: fourthBaseFirst.back = -90
            case 2: fourthBaseSecond.back = -90
            case 3: thirdBaseFirst.back = -90
            case 4: thirdBaseSecond.back = -90
            case 5: thirdBaseThird.back = -90
            case 6: secondBaseFirst.back = -90
            case 7: secondBaseSecond.back = -90
            case 8: secondBaseThird.back = -90
            case 9: secondBaseFourth.back = -90
            case 10: firstBasefirst.back = -90
            case 11: firstBaseSecond.back = -90
            case 12: firstBaseThird.back = -90
            case 13: firstBaseFourth.back = -90
            case 14: firstBaseFifth.back = -90
            default: break
            }
        }
        
        withAnimation(Animation.easeOut(duration: 0.5).delay(0.5)){
            switch index {
            case 0: fifthBase.front = 0
            case 1: fourthBaseFirst.front = 0
            case 2: fourthBaseSecond.front = 0
            case 3: thirdBaseFirst.front = 0
            case 4: thirdBaseSecond.front = 0
            case 5: thirdBaseThird.front = 0
            case 6: secondBaseFirst.front = 0
            case 7: secondBaseSecond.front = 0
            case 8: secondBaseThird.front = 0
            case 9: secondBaseFourth.front = 0
            case 10: firstBasefirst.front = 0
            case 11: firstBaseSecond.front = 0
            case 12: firstBaseThird.front = 0
            case 13: firstBaseFourth.front = 0
            case 14: firstBaseFifth.front = 0
            default: break
            }
        }
    }
    
    func flipFaceDown() {
        withAnimation(Animation.easeInOut(duration: 0.4)){
            fifthBase.front = 90
            fourthBaseFirst.front = 90
            fourthBaseSecond.front = 90
            thirdBaseFirst.front = 90
            thirdBaseSecond.front = 90
            thirdBaseThird.front = 90
            secondBaseFirst.front = 90
            secondBaseSecond.front = 90
            secondBaseThird.front = 90
            secondBaseFourth.front = 90
            firstBasefirst.front = 90
            firstBaseSecond.front = 90
            firstBaseThird.front = 90
            firstBaseFourth.front = 90
            firstBaseFifth.front = 90
        }
        
        withAnimation(Animation.easeInOut(duration: 0.4).delay(0.4)){
            fifthBase.back = 0
            fourthBaseSecond.back = 0
            fourthBaseFirst.back = 0
            thirdBaseFirst.back = 0
            thirdBaseSecond.back = 0
            thirdBaseThird.back = 0
            thirdBaseThird.back = 0
            secondBaseFirst.back = 0
            secondBaseFirst.back = 0
            secondBaseSecond.back = 0
            secondBaseThird.back = 0
            secondBaseFourth.back = 0
            firstBasefirst.back = 0
            firstBaseSecond.back = 0
            firstBaseThird.back = 0
            firstBaseFourth.back = 0
            firstBaseFifth.back = 0
        }
    }
    
    func changeBase(index: Int) {
        switch index {
        case 0: currentBase = .first
        case 1, 2: currentBase = .fifth
        case 3, 4, 5: currentBase = .fourth
        case 6, 7, 8, 9: currentBase = .third
        case 10, 11, 12, 13, 14: currentBase = .second
        default: break
        }
    }
    
    func addToPath(index: Int) {
        currentPath.append(index)
    }
    
    func restart() {
        currentPlayer = 0
        flipFaceDown()
        deck = deck.shuffled()
        currentPath.removeAll()
        currentBase = .first
        updateOpacity()
        mainLabelOpacity = 0
        substituteIndex = 15
    }
    
    func revealPunishment() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            switch currentBase {
            case .first: mainLabel = "Take 1 sip"
            case .second: mainLabel = "Take 2 sips"
            case .third: mainLabel = "Take 3 sips"
            case .fourth: mainLabel = "Take 4 sips"
            case .fifth: mainLabel = "Take 5 sips"
            }
            mainLabelOpacity = 1
        }
    }
    
    func replaceCards() {
        if substituteIndex < 47 {
            for item in currentPath {
                deck.swapAt(item, substituteIndex)
                substituteIndex += 1
                print(substituteIndex)
            }
        } else {
            let cardsOnTable = deck.prefix(upTo: 15)
            let cardInDeck = deck.suffix(from: 15)
            var newdeck: [Deck] = []
            newdeck.append(contentsOf: cardInDeck)
            newdeck = newdeck.shuffled()
            newdeck.insert(contentsOf: cardsOnTable, at: 0)
            deck = newdeck
            substituteIndex = 15
            for item in currentPath {
                deck.swapAt(item, substituteIndex)
                substituteIndex += 1
                print(substituteIndex)
            }
        }
        currentPath.removeAll()
    }
    
    func updateOpacity() {
        switch currentBase {
        case .first:
            firstBaseOpacity = 1
            secondBaseOpacity = 0.6
            thirdBaseOpacity = 0.45
            fourthBaseOpacity = 0.3
            fifthBaseOpacity = 0.1
        case .second:
            firstBaseOpacity = 0.6
            secondBaseOpacity = 1
            thirdBaseOpacity = 0.6
            fourthBaseOpacity = 0.45
            fifthBaseOpacity = 0.3
        case .third:
            firstBaseOpacity = 0.45
            secondBaseOpacity = 0.6
            thirdBaseOpacity = 1
            fourthBaseOpacity = 0.6
            fifthBaseOpacity = 0.45
        case .fourth:
            firstBaseOpacity = 0.3
            secondBaseOpacity = 0.45
            thirdBaseOpacity = 0.6
            fourthBaseOpacity = 1
            fifthBaseOpacity = 0.6
        case .fifth:
            firstBaseOpacity = 0.1
            secondBaseOpacity = 0.3
            thirdBaseOpacity = 0.45
            fourthBaseOpacity = 0.6
            fifthBaseOpacity = 1
        }
    }
}
