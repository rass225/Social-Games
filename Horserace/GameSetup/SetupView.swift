import Foundation
import SwiftUI

struct SetupView: View {
    
    @EnvironmentObject var game: Game
    
     enum Field: Int, Hashable {
        case player1, player2, player3, player4, player5, player6
    }
   
    @State var player1 = ""
    @State var player2 = ""
    @State var player3 = ""
    @State var player4 = ""
    @State var player5 = ""
    @State var player6 = ""
    
    @State var revealPlayer2 = false
    @State var revealPlayer3 = false
    @State var revealPlayer4 = false
    @State var revealPlayer5 = false
    @State var revealPlayer6 = false
    
    @State var players: [String] = []
    @State var toNext = false
    @State var isRulesOpened = false
    @State var destination: AnyView = AnyView(Text("Maintenance"))
    
    @FocusState private var focusField: Field?
    
    var body: some View {
        VStack(spacing: 16){
            NavigationLink(destination: destination.environmentObject(game), isActive: $toNext) {
                EmptyView()
            }
            ScrollView(showsIndicators: false){
                VStack(spacing: 20){
                    TextField("", text: $player1)
                        .placeholder(when: player1.isEmpty) {
                            Text("Player 1")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(BlurEffect().opacity(focusField == .player1 ? 0.4 : 1))
                        .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
                        .focused($focusField, equals: .player1)
                    
                    if revealPlayer2 {
                        TextField("", text: $player2)
                            .placeholder(when: player2.isEmpty) {
                                Text("Player 2")
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(BlurEffect().opacity(focusField == .player2 ? 0.4 : 1))
                            .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
                            .focused($focusField, equals: .player2)
                            .overlay(Remove(player: $revealPlayer2), alignment: .trailing)
                    }
                    
                    if revealPlayer3 {
                        TextField("", text: $player3)
                            .placeholder(when: player3.isEmpty) {
                                Text("Player 3")
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(BlurEffect().opacity(focusField == .player3 ? 0.4 : 1))
                            .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
                            .focused($focusField, equals: .player3)
                            .overlay(Remove(player: $revealPlayer3), alignment: .trailing)
                    }
                    
                    if revealPlayer4 {
                        TextField("", text: $player4)
                            .placeholder(when: player4.isEmpty) {
                                Text("Player 4")
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(BlurEffect().opacity(focusField == .player4 ? 0.4 : 1))
                            .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
                            .focused($focusField, equals: .player4)
                            .overlay(Remove(player: $revealPlayer4), alignment: .trailing)
                    }
                    
                    if revealPlayer5 {
                        TextField("", text: $player5)
                            .placeholder(when: player5.isEmpty) {
                                Text("Player 5")
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(BlurEffect().opacity(focusField == .player5 ? 0.4 : 1))
                            .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
                            .focused($focusField, equals: .player5)
                            .overlay(Remove(player: $revealPlayer5), alignment: .trailing)
                    }
                    
                    if revealPlayer6 {
                        TextField("", text: $player6)
                            .placeholder(when: player6.isEmpty) {
                                Text("Player 6")
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(BlurEffect().opacity(focusField == .player1 ? 0.4 : 1))
                            .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
                            .focused($focusField, equals: .player6)
                            .opacity(focusField == .player6 ? 0.4 : 1)
                            .overlay(Remove(player: $revealPlayer6), alignment: .trailing)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                .foregroundColor(Colors.text)
                
                
                if !areMaxPlayers() {
                    Button(action: {
                        withAnimation{
                            addPlayer()
                        }
                    }) {
                        newPlayerButtonLabel
                    }.padding(.top)
                }
            }
            
            
//            Spacer()
            Button(action: {
                finalizePlayers()
            }) {
                MainButton(label: "Next")
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
        }
        .sheet(isPresented: $isRulesOpened) {
            RuleView(isOpen: $isRulesOpened)
        }
        .padding(.bottom, 20)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesButton(isRulesOpened: $isRulesOpened)
            }
            ToolbarItem(placement: .principal) {
                game.title
                    .font(.headline.weight(.regular))
                    .foregroundColor(Colors.text)
            }
        }
        .onAppear{
            print("Game mode: \(game.game.rawValue)")
        }
    }
    
    private struct Remove: View {
        @Binding var player: Bool
        
        var body : some View {
            Button(action: {
                withAnimation{
                    player.toggle()
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, Colors.red)
                    .font(.title2)
                    .padding(8)
            }
        }
    }
    
    var newPlayerButtonLabel: some View {
        Image(systemName: "plus.circle.fill")
            .resizable()
            .frame(width: 50, height: 50)
            .font(.body.weight(.light))
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, Colors.green)
    }
    
    func areMaxPlayers() -> Bool {
        guard revealPlayer2 == true else { return false }
        guard revealPlayer3 == true else { return false }
        guard revealPlayer4 == true else { return false }
        guard revealPlayer5 == true else { return false }
        guard revealPlayer6 == true else { return false }
        return true
    }
    
    func addPlayer() {
        guard revealPlayer2 == true else {
            revealPlayer2.toggle()
            return
        }
        guard revealPlayer3 == true else {
            revealPlayer3.toggle()
            return
        }
        guard revealPlayer4 == true else {
            revealPlayer4.toggle()
            return
        }
        guard revealPlayer5 == true else {
            revealPlayer5.toggle()
            return
        }
        guard revealPlayer6 == true else {
            revealPlayer6.toggle()
            return
        }
    }
    
    func finalizePlayers() {
        if !players.isEmpty {
            players = []
        }
        if player1.isEmpty {
            players.append("Player 1")
        } else {
            players.append(player1)
        }
        if revealPlayer2 {
            if player2.isEmpty {
                players.append("Player 2")
            } else {
                players.append(player2)
            }
        }
        if revealPlayer3 {
            if player3.isEmpty {
                players.append("Player 3")
            } else {
                players.append(player3)
            }
        }
        if revealPlayer4 {
            if player4.isEmpty {
                players.append("Player 4")
            } else {
                players.append(player4)
            }
        }
        if revealPlayer5 {
            if player5.isEmpty {
                players.append("Player 5")
            } else {
                players.append(player5)
            }
        }
        if revealPlayer6 {
            if player6.isEmpty {
                players.append("Player 6")
            } else {
                players.append(player6)
            }
        }
        print(players)
        
        navigateToGame()
    }
    
    func navigateToGame() {
        switch game.game {
        case .horseRace:
            destination = AnyView(HorseRaceSuits(players: players))
        case .kingsCup:
            destination = AnyView(KingsCupGame(players: players))
        case .truthDare:
            destination = AnyView(TruthOrDareGame(players: players))
        case .neverHaveIEver:
            destination = AnyView(NeverHaveIEverGame(players: players))
        case .pyramid:
            destination = AnyView(PyramidGame(players: players))
        case .spinBottle:
            break
        case .whosMostLikely:
            break
        case .higherLower:
            destination = AnyView(HigherLowerGame(players: players))
        case .chooser:
            destination = AnyView(ChooserGame())
        case .explain:
            break
        case .roulette:
            destination = AnyView(RouletteGame(players: players))
        case .wheel:
            destination = AnyView(WheelComponents(players: players))
        }
        toNext.toggle()
    }
}
