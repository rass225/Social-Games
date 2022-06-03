import SwiftUI

struct SpinBottleGame: View {
    
    @EnvironmentObject var game: Game
    @StateObject var model = SpinBottleModel()
    @State var isRulesOpen: Bool = false
    
    
    private let spinAnimation: Animation = Animation.easeOut(duration: 4.0)
    
    var body: some View {
        VStack{
            GeometryReader { geo in
                let size = geo.size
                RoundedRectangle(cornerRadius: 16)
                    .fill(game.game.gradient)
                    .mask{
                        Images.bottle
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: size.width)
                    }
                    .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 0)
                    .rotationEffect(Angle(degrees: model.spinDegrees))
                    .animation(spinAnimation, value: model.spinDegrees)
                    .overlay{
                        if !model.hasGameStarted {
                            Text("Tap to spin")
                                .font(.title3.weight(.regular))
                                .foregroundColor(Colors.text)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(.ultraThinMaterial)
                                .cornerRadius(8)
                        }
                    }
                    .onTapGesture {
                        model.spinBottle()
                    }
            }.padding(.horizontal)
        }
        .navigationModifier(game: .spinBottle)
        .gameViewModifier(game: .spinBottle)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                HomeButton()
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
    }
}
