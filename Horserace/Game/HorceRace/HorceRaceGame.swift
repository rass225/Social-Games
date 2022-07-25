import SwiftUI

struct HorceRaceGame: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var game: Game
    @ObservedObject var model: HorseRaceModel
    @State var isRulesOpen: Bool = false
    @AppStorage("HorseraceHeartWins") var heartWins = 0
    @AppStorage("HorseraceDiamondWins") var diamondWins = 0
    @AppStorage("HorseraceSpadeWins") var spadeWins = 0
    @AppStorage("HorseraceClubWins") var clubWins = 0
    
    
    var winner: Suit? {
        return model.winnerSuit
    }
    
    let columns = [
        GridItem(.flexible(maximum: .infinity), spacing: 0, alignment: .center),
        GridItem(.flexible(maximum: .infinity), spacing: 0, alignment: .center),
        GridItem(.flexible(maximum: .infinity), spacing: 0, alignment: .center)
    ]
    
    init(players: [HorseRacePlayers]) {
        model = HorseRaceModel(players: players)
    }
    
    var body: some View {
        VStack{
            playersBoard
            GeometryReader { geometry in
                let size = geometry.size
                ZStack(alignment: .bottomTrailing){
                    Finishline(size: size)
                        
                    VStack{
                        Spacer()
                        HStack(spacing: 16){
                            Spacer()
                            Card(suit: .heart, rank: .ace, size: .small, geometry: size)
                                .offset(x: 0, y: -geometry.size.height / 100 * model.heartOffset)
                            Card(suit: .diamond, rank: .ace, size: .small, geometry: size)
                                .offset(x: 0, y: -geometry.size.height / 100 * model.diamondOffset)
                            Card(suit: .spades, rank: .ace, size: .small, geometry: size)
                                .offset(x: 0, y: -geometry.size.height / 100 * model.spadeOffset)
                            Card(suit: .clubs, rank: .ace, size: .small, geometry: size)
                                .offset(x: 0, y: -geometry.size.height / 100 * model.clubOffset)
                            Spacer()
                        }
                    }
                    FullCard(card: $model.deck[4], rotation: $model.fifthBase, size: .small, geo: size)
                        .offset(x: 0, y: -geometry.size.height / 100 * 75)
                    FullCard(card: $model.deck[3], rotation: $model.fourthBase, size: .small, geo: size)
                        .offset(x: 0, y: -geometry.size.height / 100 * 60)
                    FullCard(card: $model.deck[2], rotation: $model.thirdBase, size: .small, geo: size)
                        .offset(x: 0, y: -geometry.size.height / 100 * 45)
                    FullCard(card: $model.deck[1], rotation: $model.secondBase, size: .small, geo: size)
                        .offset(x: 0, y: -geometry.size.height / 100 * 30)
                    FullCard(card: $model.deck[0], rotation: $model.firstBase, size: .small, geo: size)
                        .offset(x: 0, y: -geometry.size.height / 100 * 15)
                   
                    
                    ZStack{
                        ForEach(0..<6, id: \.self) { index in
                            Card(suit: .diamond, rank: .two, size: .small, geometry: size)
                                .rotationEffect(.degrees(Double(30 - (index  * 5))))
                        }
                        switch model.state {
                        case .notStarted, .winner:
                            CardBack(size: .small, geometry: size)
                        case .game:
                            Card(suit: model.deck[model.deckIndex].suit, rank: model.deck[model.deckIndex].rank, size: .small, geometry: size)
                        }
                    }
                }
            }
            
            Button(action: {
                model.gameLogic()
            }) {
                MainButton(label: model.mainLabel)
            }
            .opacity(model.winnerSuit == nil ? 1 : 0)
            .disabled(model.winnerSuit == nil ? false : true)
            .buttonStyle(PlainButtonStyle())
            .padding(.top)
        }
        .gameViewModifier(game: .horseRace)
        .navigationModifier(game: .horseRace)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                HomeButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    Section{
                        Button(action: {
                            isRulesOpen.toggle()
                        }) {
                            Text("Rules")
                            Images.rulesFill
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, game.game.gradient)
                        }
                    }
                    Section{
                        Button(action: {
                            model.restart()
                        }) {
                            Text("Restart")
                            Images.restart
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, game.game.gradient)
                                .font(.title)
                        }
                    }
                }, label: {
                    GameMenuButton()
                })
            }
            ToolbarItem(placement: .principal) {
                GameTitle()
            }
        }
        .sheet(isPresented: $model.isThereAWinner) {
            gameOver
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
    }
}
//Mariah is my love
