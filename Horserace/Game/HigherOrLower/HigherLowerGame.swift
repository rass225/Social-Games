import SwiftUI

struct HigherLowerGame: View {
    
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: HigherLowerModel
    
    init(players: [String]) {
        model = HigherLowerModel(players: players)
    }
    
    var body: some View {
        VStack(spacing: 0){
            PlayersBoard(currentPlayer: $model.currentPlayer, hasPlayersShuffled: $model.hasPlayersShuffled, players: $model.players)
            HStack(spacing: 8){
                Statistic(data: $model.record, type: .record)
                Statistic(data: $model.currentRecord, type: .currentRecord)
                Statistic(data: $model.currentStreak, type: .currentStreak)
            }
            GeometryReader { geo in
                let size = geo.size
                Text(model.mainLabel)
                    .font(.title.weight(.regular))
                    .foregroundColor(Colors.text)
                    .maxWidth(alignment: .center)
                    .padding(.top, 32)
                    
                   
                VStack{
                    Spacer()
                    HStack(spacing: 20){
                        ZStack{
                            ForEach($model.dealtCards) { item in
                                FullCard(card: item, rotation: $model.leftCardRotation, size: .extraLarge, geo: size)
                            }
                        }
                        ZStack{
                            ForEach(model.undealtCards.indices, id: \.self) { index in
                                if index == model.undealtCards.count - 1 {
                                    FullCard(card: $model.undealtCards[index], rotation: $model.rightCardRotation, size: .extraLarge, geo: size)
                                        .offset(x: model.offsetX, y: 0)
                                } else {
                                    FullCard(card: $model.undealtCards[index], rotation: $model.rightSecondCardRotation, size: .extraLarge, geo: size)
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
                        Button("Higher") {
                            model.pickHigher(size: size)
                        }
                        .buttonStyle(MainButtonStyle())
                        .disabled(model.isAnimating)
                        .opacity(model.isAnimating ? 0.4 : 1)
                        Button("Lower") {
                            model.pickLower(size: size)
                        }
                        .buttonStyle(MainButtonStyle())
                        .disabled(model.isAnimating)
                        .opacity(model.isAnimating ? 0.4 : 1)
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
                Menu(content: {
                    Section{
                        Button(action: model.showRules) {
                            MenuLabel(.rules)
                        }
                    }
                    Section{
                        Button(action: model.restart) {
                            MenuLabel(.restart)
                        }
                    }
                }, label: {
                    GameMenuButton()
                })
            }
        }
        .sheet(isPresented: $model.isRulesOpen) {
            RuleView(isOpen: $model.isRulesOpen)
        }
        .onAppear(perform: model.initialize)
    }
    
    struct Statistic: View {
        
        @EnvironmentObject var game: Game
        
        @Binding var data: Int
        let type: StatType
        
        var systemImage: String {
            switch type {
            case .record: return "crown.fill"
            case .currentRecord: return "flame.fill"
            case .currentStreak: return "flame"
            }
        }
        
        enum StatType {
            case record
            case currentRecord
            case currentStreak
        }
        
        var body: some View {
            HStack(spacing: 4){
                Image(systemName: systemImage)
                    .font(.title2)
                    .foregroundStyle(game.game.gradient)
                    .frame(height: 25)
                Text("\(data)")
                    .font(.title3.weight(.medium))
                    .textCase(.uppercase)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(.ultraThickMaterial)
            .mask(RoundCorners(cornerRadius: 8))
            .shadow(color: Colors.darkShadow2, radius: 5, x: 0, y: 8)
        }
    }
}
