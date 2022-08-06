import SwiftUI

struct HorseRaceSuits: View {
    
    @EnvironmentObject var game: Game
    let players: [String]
    
    let columns = [
        GridItem(.flexible(maximum: .infinity), spacing: 16),
        GridItem(.flexible(maximum: .infinity), spacing: 16)
    ]
    @State var isRulesOpened: Bool = false
    @State var playerSuits: [HorseRacePlayers] = []
    @State var toGame: Bool = false
    
    @AppStorage("HorseraceHeartWins") var heartWins = 0
    
    @AppStorage("HorseraceDiamondWins") var diamondWins = 0
    
    @AppStorage("HorseraceSpadeWins") var spadeWins = 0
    
    @AppStorage("HorseraceClubWins") var clubWins = 0
    private var allSet: Bool {
        if playerSuits.contains(where: { $0.suit == nil }) {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        VStack{
            NavigationLink(destination: HorceRaceGame(players: playerSuits).environmentObject(game), isActive: $toGame) {
                EmptyView()
            }
            VStack(spacing: 16){
                Text("Historic wins")
                    .font(.subheadline.weight(.semibold))
                    .textCase(.uppercase)
                HStack(spacing: 20){
                    HStack(spacing: 2){
                        Images.heart
                            .font(.title2)
                            .foregroundColor(Colors.red)
                        Text("\(heartWins)")
                    }
                    HStack(spacing: 2){
                        Images.diamond
                            .font(.title2)
                            .foregroundColor(Colors.red)
                        Text("\(diamondWins)")
                    }
                    HStack(spacing: 2){
                        Images.club
                            .font(.title2)
                            .foregroundColor(.black)
                        Text("\(clubWins)")
                    }
                    HStack(spacing: 2){
                        Images.spade
                            .font(.title2)
                            .foregroundColor(.black)
                        Text("\(spadeWins)")
                    }
                }
            }
            .font(.body.weight(.regular))
            .padding(.top, 8)
            .padding(.bottom)
            .maxWidth()
            .background(.ultraThickMaterial)
            .mask(RoundCorners(cornerRadius: 12))
            .shadow(color: Colors.darkShadow2, radius: 5, x: 0, y: 8)
            .padding(.bottom)
            LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                ForEach(playerSuits.indices, id: \.self) { index in
                    VStack(spacing: 0){
                        PlayerName(label: playerSuits[index].name)
                        Divider()
                            .background(.ultraThickMaterial)
                        HStack{
                            if playerSuits[index].suit == nil || playerSuits[index].suit == .heart {
                                Button(action: {
                                    pickSuit(index: index, suit: .heart)
                                }) {
                                    Images.heart
                                        .foregroundColor(.red.opacity(playerSuits[index].suit == .heart ? 1 : 0.4))
                                }
                            }
                            if playerSuits[index].suit == nil || playerSuits[index].suit == .diamond {
                                Button(action: {
                                    pickSuit(index: index, suit: .diamond)
                                }) {
                                    Images.diamond
                                        .foregroundColor(.red.opacity(playerSuits[index].suit == .diamond ? 1 : 0.4))
                                }
                            }
                            if playerSuits[index].suit == nil || playerSuits[index].suit == .clubs {
                                Button(action: {
                                    pickSuit(index: index, suit: .clubs)
                                }) {
                                    Images.club
                                        .foregroundColor(.black.opacity(playerSuits[index].suit == .clubs ? 1 : 0.4))
                                }
                            }
                            
                            if playerSuits[index].suit == nil || playerSuits[index].suit == .spades {
                                Button(action: {
                                    pickSuit(index: index, suit: .spades)
                                }) {
                                    Images.spade
                                        .foregroundColor(.black.opacity(playerSuits[index].suit == .spades ? 1 : 0.4))
                                }
                            }
                        }
                        .padding(.vertical, 12)
                        .font(.title)
                    }
                    .background(game.game.gradient)
                    .cornerRadius(16)
                }
            }
            Spacer()
            
            Button("Play", action: routeToGame)
                .buttonStyle(MainButtonStyle())
                .opacity(allSet ? 1 : 0.7)
                .disabled(allSet ? false : true)
        }
        .padding(.horizontal, 20)
        .padding(.vertical)
        .padding(.top)
        .background(
            DefaultBackground()
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesButton(isOpen: $isRulesOpened)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .principal) {
                Text("Pick a Horse")
                    .textCase(.uppercase)
                    .font(.callout.weight(.semibold))
                    .foregroundColor(Colors.text)
            }
        }
        .sheet(isPresented: $isRulesOpened) {
            RuleView(isOpen: $isRulesOpened)
        }
        .onAppear{
            for item in players {
                playerSuits.append(HorseRacePlayers(name: item, suit: nil))
            }
        }
    }
    
    private struct PlayerName: View {
        let label: String
        var body: some View {
            Text(label)
                .padding(.vertical, 12)
                .font(.headline.weight(.regular))
                .foregroundColor(Color.white)
        }
    }
    
    func pickSuit(index: Int, suit: Suit) {
        if playerSuits[index].suit != nil {
            withAnimation(.easeOut(duration: 0.5)) {
                playerSuits[index].suit = nil
            }
        } else {
            withAnimation(.easeOut(duration: 0.5)) {
                playerSuits[index].suit = suit
            }
        }
        
    }
    
    func routeToGame() {
        for item in playerSuits {
            print("\(item.name) picked \(item.suit ?? .diamond)")
        }
        toGame.toggle()
    }
}

struct HorseRacePlayers: Hashable {
    var id = UUID()
    var name: String
    var suit: Suit?
}
