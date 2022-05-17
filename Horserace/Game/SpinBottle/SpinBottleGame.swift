import SwiftUI

struct SpinBottleGame: View {
    
    @EnvironmentObject var game: Game
    @ObservedObject var model: SpinBottleModel
    @State var isRulesOpen: Bool = false
    
    init() {
        model = SpinBottleModel()
    }
    
    var body: some View {
        VStack{
            GeometryReader { geo in
                let size = geo.size
                VStack{
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)).fill(.regularMaterial)
                        .mask{
                            Image("Bottle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: size.width)
                                
                
                        }
                        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 10)
                        .rotationEffect(Angle(degrees: model.spinDegrees))
                        .animation(Animation.easeOut(duration: 4.0)
                            .repeatCount(1, autoreverses: false), value: model.spinDegrees)
                        .onTapGesture {
                            model.spinBottle()
                        }
                }
                .maxHeight()
                .maxWidth()
                VStack{
                    if !model.hasGameStarted {
                        Text("Tap to spin")
                            .font(.title3.weight(.regular))
                            .foregroundColor(Colors.text)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(.ultraThinMaterial)
                            .cornerRadius(8)
                    }
                    Spacer()
                }
                .padding(.top, 40)
                .maxWidth()

            }
            .padding(.horizontal)
           
        }
        .navigationModifier(game: .spinBottle)
        .gameViewModifier(game: .spinBottle)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    RulesMenuButton(isOpen: $isRulesOpen)
                    MainMenuMenuButton()
                }, label: {
                    Burger()
                })
                .disabled(model.isAnimating ? true : false)
                .opacity(model.isAnimating ? 0 : 1)
            }
            GameTitle(game: .spinBottle)
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
    }
}
