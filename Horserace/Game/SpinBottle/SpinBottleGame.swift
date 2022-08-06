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
                    .gesture(
                        DragGesture()
                            .onChanged({ (value) in
                                let width = value.translation.width
                                let height = value.translation.height
                                if height > width {
                                    model.spinBottle(value: value.translation.height)
                                } else {
                                    model.spinBottle(value: value.translation.width)
                                }
                                
                            })
                    )
                    .overlay{
                        if !model.hasGameStarted {
                            overlay
                        }
                    }
            }
        }
        .navigationModifier(game: .spinBottle)
        .padding(.horizontal, 12)
        .padding(.bottom)
        .padding(.top)
        .background(DefaultBackground())
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesButton(isOpen: $isRulesOpen)
            }
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
    }
    
    var overlay: some View {
        Text("Swipe to spin")
            .font(.title3.weight(.regular))
            .foregroundColor(Colors.text)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
    }
}
